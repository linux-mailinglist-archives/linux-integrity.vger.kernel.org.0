Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C8A686B17
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Feb 2023 17:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjBAQF6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Feb 2023 11:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjBAQF5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Feb 2023 11:05:57 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F64410BE;
        Wed,  1 Feb 2023 08:05:52 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4P6RQH1nS4z9xrpw;
        Wed,  1 Feb 2023 23:57:43 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwC3OQXKjdpj_fflAA--.13349S2;
        Wed, 01 Feb 2023 17:05:38 +0100 (CET)
Message-ID: <f0da60dd3cb3ed7857aaa64fb5289d5aace844cd.camel@huaweicloud.com>
Subject: Re: [PATCH ima-evm-utils v2] Add tests for MMAP_CHECK and
 MMAP_CHECK_REQPROT hooks
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        pvorel@suse.cz, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 01 Feb 2023 17:05:18 +0100
In-Reply-To: <deec5230-b72e-3325-3dfc-fb8c818526a4@linux.ibm.com>
References: <20230131174245.2343342-1-roberto.sassu@huaweicloud.com>
         <20230131174245.2343342-3-roberto.sassu@huaweicloud.com>
         <deec5230-b72e-3325-3dfc-fb8c818526a4@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwC3OQXKjdpj_fflAA--.13349S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4kAw1fGFy8JF48Gr15urg_yoWrtw47pF
        yvvFZrtFWUtFW7X3s5uF1qqrnaqr1IyF17J3s8Kw1UArs09a4Igr4Utr4DuF97WrZ8Xa1k
        Za1UXr43uwn8tFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBF1jj4RrfwAAso
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-01-31 at 17:39 -0500, Stefan Berger wrote:
> 
> On 1/31/23 12:42, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > +check_mmap() {
> > +	local hook="$1"
> > +	local arg="$2"
> > +	local test_file fowner rule result test_file_entry
> > +
> > +	echo -e "\nTest: ${FUNCNAME[0]} (hook=\"$hook\", test_mmap arg: \"$arg\")"
> > +
> > +	if ! test_file=$(mktemp -p "$PWD"); then
> > +		echo "${RED}Cannot write $test_file${NORM}"
> > +		return "$HARDFAIL"
> > +	fi
> > +
> > +	fowner="$MMAP_CHECK_FOWNER"
> > +	rule="$MEASURE_MMAP_CHECK_RULE"
> > +
> > +	if [ "$hook" = "MMAP_CHECK_REQPROT" ]; then
> > +		fowner="$MMAP_CHECK_REQPROT_FOWNER"
> > +		rule="$MEASURE_MMAP_CHECK_REQPROT_RULE"
> > +	fi
> > +
> > +	if ! chown "$fowner" "$test_file"; then
> > +		echo "${RED}Cannot change owner of $test_file${NORM}"
> > +		return "$HARDFAIL"
> > +	fi
> > +
> > +	check_load_ima_rule "$rule"
> > +	result=$?
> > +	if [ $result -ne "$OK" ]; then
> > +		return $result
> > +	fi
> > +
> > +	test_mmap "$test_file" "$arg"
> 
> In this case it should succeed or fail depending on the $rule?  I am just wondering whether to check $? here as well for expected outcome...

I agree. For the check_mmap() test, test_mmap is always expected to
succeed.

> > +
> > +	if [ "$TFAIL" != "yes" ]; then
> > +		echo -n "Result (expect found): "
> > +	else
> > +		echo -n "Result (expect not found): "
> > +	fi
> > +
> > +	test_file_entry=$(awk '$5 == "'"$test_file"'"' < /sys/kernel/security/ima/ascii_runtime_measurements)
> > +	if [ -z "$test_file_entry" ]; then
> > +		echo "not found"
> > +		return "$FAIL"
> > +	fi
> > +
> > +	echo "found"
> > +	return "$OK"
> > +}
> > +if [ -n "$TST_KEY_PATH" ]; then
> > +	if [ "${TST_KEY_PATH:0:1}" != "/" ]; then
> > +		echo "${RED}Absolute path required for the signing key${NORM}"
> > +		exit "$FAIL"
> > +	fi
> > +
> > +	if [ ! -f "$TST_KEY_PATH" ]; then
> > +		echo "${RED}Kernel signing key not found in $TST_KEY_PATH${NORM}"
> > +		exit "$FAIL"
> > +	fi
> > +
> > +	key_path="$TST_KEY_PATH"
> 
> g_key_path ? or pass as parameter to check_deny (better IMO)

There are other global variables. Also the expect_ lines now are clean
and say more or less what the test is about. Maybe better g_key_path,
will think about for new tests.

> > +elif [ -f "$PWD/../signing_key.pem" ]; then
> > +	key_path="$PWD/../signing_key.pem"
> > +elif [ -f "/lib/modules/$(uname -r)/source/certs/signing_key.pem" ]; then
> > +	key_path="/lib/modules/$(uname -r)/source/certs/signing_key.pem"
> > +elif [ -f "/lib/modules/$(uname -r)/build/certs/signing_key.pem" ]; then
> > +	key_path="/lib/modules/$(uname -r)/build/certs/signing_key.pem"
> > +else
> > +	echo "${CYAN}Kernel signing key not found${NORM}"
> > +	exit "$SKIP"
> > +fi
> > +
> > +key_path_der=$(mktemp)
> 
> g_key_path_der for consistency

Ok.

> > +++ b/tests/test_mmap.c
> > @@ -0,0 +1,75 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
> > + *
> > + * Tool to test IMA MMAP_CHECK and MMAP_CHECK_REQPROT hooks.
> > + */
> > +#include <stdio.h>
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +#include <sys/stat.h>
> > +#include <sys/mman.h>
> > +#include <sys/personality.h>
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +	struct stat st;
> > +	void *ptr, *ptr_write = NULL;
> > +	int ret, fd, fd_write, prot = PROT_READ;
> > +
> > +	if (!argv[1])
> > +		return -ENOENT;
> > +
> > +	if (argv[2] && !strcmp(argv[2], "read_implies_exec")) {
> > +		ret = personality(READ_IMPLIES_EXEC);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +
> > +	if (stat(argv[1], &st) == -1)
> > +		return -errno;
> > +
> > +	if (argv[2] && !strcmp(argv[2], "exec_on_writable")) {
> > +		fd_write = open(argv[1], O_RDWR);
> > +		if (fd_write == -1)
> > +			return -errno;
> > +
> > +		ptr_write = mmap(0, st.st_size, PROT_WRITE, MAP_SHARED,
> > +				 fd_write, 0);
> > +		close(fd_write);
> > +
> > +		if (ptr_write == (void *)-1)
> > +			return -errno;
> > +	}
> > +
> > +	fd = open(argv[1], O_RDONLY);
> > +	if (fd == -1) {
> > +		if (ptr_write)
> > +			munmap(ptr_write, st.st_size);
> > +
> > +		return -errno;
> > +	}
> > +
> > +	if (argv[2] && !strncmp(argv[2], "exec", 4))
> > +		prot |= PROT_EXEC;
> > +
> > +	ptr = mmap(0, st.st_size, prot, MAP_PRIVATE, fd, 0);
> > +
> > +	close(fd);
> > +
> > +	if (ptr_write)
> > +		munmap(ptr_write, st.st_size);
> > +
> > +	if (ptr == (void *)-1)
> > +		return -errno;
> > +
> > +	ret = 0;
> > +
> > +	if (argv[2] && !strcmp(argv[2], "mprotect"))
> > +		ret = mprotect(ptr, st.st_size, PROT_EXEC);
> > +
> > +	munmap(ptr, st.st_size);
> > +	return ret;
> > +}
> 
> Are there any unexpected failure cases here where it should report an error to the user?

Uhm, ok. I differentiated when an error could occur from when it should
not.

Roberto

