default: docker-run

all: docker-build docker-run

pristine: clean clean-sources fetch-sources docker-build docker-run

docker-build: docker-build-android docker-build-ios
docker-build-android:
	docker build . -t svg-to-android -f Dockerfile.android
docker-build-ios:
	docker build . -t svg-to-ios -f Dockerfile.ios

docker-run: docker-run-android docker-run-ios
docker-run-android:
	docker run --rm -it  -v $$(PWD)/mounts/input:/mounts/input -v $$(PWD)/mounts/output:/mounts/output svg-to-android
docker-run-ios:
	docker run --rm -it  -v $$(PWD)/mounts/input:/mounts/input -v $$(PWD)/mounts/output:/mounts/output svg-to-ios

clean: clean-android clean-ios
clean-android:
	rm -rf mounts/output/android/*
clean-ios:
	rm -rf mounts/output/ios/*

clean-sources:
	rm -rf src/main/java/com/android

fetch-sources: clean-sources
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'https://raw.githubusercontent.com/JetBrains/adt-tools-base/master/sdk-common/src/main/java/com/android/ide/common/vectordrawable/Svg2Vector.java'	-o src/main/java/com/android/ide/common/vectordrawable/Svg2Vector.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'https://raw.githubusercontent.com/JetBrains/adt-tools-base/master/sdk-common/src/main/java/com/android/ide/common/vectordrawable/SvgTree.java'		-o src/main/java/com/android/ide/common/vectordrawable/SvgTree.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'https://raw.githubusercontent.com/JetBrains/adt-tools-base/master/sdk-common/src/main/java/com/android/ide/common/vectordrawable/PathBuilder.java'	-o src/main/java/com/android/ide/common/vectordrawable/PathBuilder.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'https://raw.githubusercontent.com/JetBrains/adt-tools-base/master/sdk-common/src/main/java/com/android/ide/common/vectordrawable/SvgGroupNode.java'	-o src/main/java/com/android/ide/common/vectordrawable/SvgGroupNode.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'https://raw.githubusercontent.com/JetBrains/adt-tools-base/master/sdk-common/src/main/java/com/android/ide/common/vectordrawable/SvgNode.java'		-o src/main/java/com/android/ide/common/vectordrawable/SvgNode.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'https://raw.githubusercontent.com/JetBrains/adt-tools-base/master/sdk-common/src/main/java/com/android/ide/common/vectordrawable/SvgLeafNode.java'	-o src/main/java/com/android/ide/common/vectordrawable/SvgLeafNode.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'https://raw.githubusercontent.com/JetBrains/adt-tools-base/master/sdk-common/src/main/java/com/android/ide/common/vectordrawable/PathParser.java'	-o src/main/java/com/android/ide/common/vectordrawable/PathParser.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'https://raw.githubusercontent.com/JetBrains/adt-tools-base/master/sdk-common/src/main/java/com/android/ide/common/vectordrawable/VdPath.java'		-o src/main/java/com/android/ide/common/vectordrawable/VdPath.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'https://raw.githubusercontent.com/JetBrains/adt-tools-base/master/sdk-common/src/main/java/com/android/ide/common/vectordrawable/VdElement.java'		-o src/main/java/com/android/ide/common/vectordrawable/VdElement.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'https://raw.githubusercontent.com/JetBrains/adt-tools-base/master/sdk-common/src/main/java/com/android/ide/common/vectordrawable/EllipseSolver.java' -o src/main/java/com/android/ide/common/vectordrawable/EllipseSolver.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'https://raw.githubusercontent.com/JetBrains/adt-tools-base/master/sdk-common/src/main/java/com/android/ide/common/vectordrawable/VdNodeRender.java'	-o src/main/java/com/android/ide/common/vectordrawable/VdNodeRender.java

	mkdir -p src/main/java/com/android					&& curl --silent 'https://raw.githubusercontent.com/JetBrains/adt-tools-base/master/common/src/main/java/com/android/SdkConstants.java'							-o src/main/java/com/android/SdkConstants.java
	mkdir -p src/main/java/com/android/utils			&& curl --silent 'https://raw.githubusercontent.com/JetBrains/adt-tools-base/master/common/src/main/java/com/android/utils/PositionXmlParser.java'				-o src/main/java/com/android/utils/PositionXmlParser.java
	mkdir -p src/main/java/com/android/utils			&& curl --silent 'https://raw.githubusercontent.com/JetBrains/adt-tools-base/master/common/src/main/java/com/android/utils/XmlUtils.java'						-o src/main/java/com/android/utils/XmlUtils.java
	mkdir -p src/main/java/com/android/ide/common/blame	&& curl --silent 'https://raw.githubusercontent.com/JetBrains/adt-tools-base/master/common/src/main/java/com/android/ide/common/blame/SourcePosition.java'		-o src/main/java/com/android/ide/common/blame/SourcePosition.java
	mkdir -p src/main/java/com/android/ide/common/blame	&& curl --silent 'https://raw.githubusercontent.com/JetBrains/adt-tools-base/master/common/src/main/java/com/android/ide/common/blame/SourceFilePosition.java'	-o src/main/java/com/android/ide/common/blame/SourceFilePosition.java
	mkdir -p src/main/java/com/android/ide/common/blame	&& curl --silent 'https://raw.githubusercontent.com/JetBrains/adt-tools-base/master/common/src/main/java/com/android/ide/common/blame/SourceFile.java'			-o src/main/java/com/android/ide/common/blame/SourceFile.java

	mkdir -p src/main/java/com/android/annotations				&& curl --silent 'https://raw.githubusercontent.com/JetBrains/adt-tools-base/master/annotations/src/main/java/com/android/annotations/NonNull.java'					-o src/main/java/com/android/annotations/NonNull.java
	mkdir -p src/main/java/com/android/annotations				&& curl --silent 'https://raw.githubusercontent.com/JetBrains/adt-tools-base/master/annotations/src/main/java/com/android/annotations/Nullable.java'				-o src/main/java/com/android/annotations/Nullable.java
	mkdir -p src/main/java/com/android/annotations/concurrency	&& curl --silent 'https://raw.githubusercontent.com/JetBrains/adt-tools-base/master/annotations/src/main/java/com/android/annotations/concurrency/Immutable.java'	-o src/main/java/com/android/annotations/concurrency/Immutable.java
