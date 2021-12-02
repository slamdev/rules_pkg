package main

import (
	"archive/tar"
	"flag"
	"fmt"
	"io"
	"log"
	"os"
	"path"
	"strconv"
)

type arrayFlag []string

var files arrayFlag
var dir string
var out string
var sizeInfoFile string

func init() {
	flag.Var(&files, "file", "file to add to archive, can be set multiple times")
	flag.StringVar(&dir, "dir", "", "an absolute path to use as a prefix for all files in the tar")
	flag.StringVar(&out, "out", "", "archive destination")
	flag.StringVar(&sizeInfoFile, "size-info", "", "file to output archive size")
	flag.Parse()
}

func main() {
	if err := archiveFile(files, out, dir); err != nil {
		log.Fatalf("%+v", err)
	}

	if err := dumpSizeInfo(out, sizeInfoFile); err != nil {
		log.Fatalf("%+v", err)
	}
}

func archiveFile(files []string, out string, dir string) error {
	file, err := os.Create(out)

	if err != nil {
		return fmt.Errorf("failed to create %s file", out)
	}
	defer file.Close()

	tarWriter := tar.NewWriter(file)
	defer tarWriter.Close()

	for _, filePath := range files {
		err := addFile(filePath, dir, tarWriter)
		if err != nil {
			return fmt.Errorf("failed to add %s file to archive", filePath)
		}
	}

	return nil
}

func addFile(filename string, dir string, tw *tar.Writer) error {
	file, err := os.Open(filename)
	if err != nil {
		return fmt.Errorf("failed to open %s file; %w", filename, err)
	}
	defer file.Close()

	info, err := file.Stat()
	if err != nil {
		return fmt.Errorf("failed to get %s file info; %w", filename, err)
	}

	header := &tar.Header{
		Name:     path.Join(dir, filename),
		Size:     info.Size(),
		Mode:     int64(info.Mode().Perm()),
		Typeflag: tar.TypeReg,
	}

	err = tw.WriteHeader(header)
	if err != nil {
		return fmt.Errorf("failed to write tar header for %s; %w", header.Name, err)
	}

	_, err = io.Copy(tw, file)
	if err != nil {
		return fmt.Errorf("failed to add %s to archive; %w", filename, err)
	}

	return nil
}

func dumpSizeInfo(file string, out string) error {
	info, err := os.Stat(file)
	if err != nil {
		return fmt.Errorf("failed to get %s file info; %w", file, err)
	}
	size := []byte(strconv.FormatInt(info.Size(), 10))
	if err := os.WriteFile(out, size, 0644); err != nil {
		return fmt.Errorf("failed to write to %s file; %w", out, err)
	}
	return nil
}

func (i *arrayFlag) String() string {
	return ""
}

func (i *arrayFlag) Set(value string) error {
	*i = append(*i, value)
	return nil
}
