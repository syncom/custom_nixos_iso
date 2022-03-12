mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_dir := $(dir $(mkfile_path))

all: docker

iso:
	$(mkfile_dir)/build_iso.sh 2>/dev/null

clean:
	rm -rf $(mkfile_dir)/out

# Prune everything
dockerclean:
	docker system prune -a -f
