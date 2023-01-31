Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D08683974
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Jan 2023 23:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjAaWjx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Jan 2023 17:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjAaWjx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Jan 2023 17:39:53 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9E5F746;
        Tue, 31 Jan 2023 14:39:49 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VMJdii038789;
        Tue, 31 Jan 2023 22:39:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=BKcYaxcWYH/ofWDt8+sbufGNtI9zvO8cCx8Veh2f5cI=;
 b=Y30+wvqLCgv1nnLfSuu7/AS1XxPzVj8L+hAoETMMuHEjG2/2r6rI2J/Qd1+9Oz2st4PJ
 op6a/XprX9/OiLgX2Ii/JquEMFyR+F17dAxgcISD18+rtakHcN8s71RtrexFpiRkq1o8
 J151GDoEbnP/PUJdqx+fyW0hpwzxSDwrJv6WZ3siJTpAcneB8shff1tuC3th4HCMAvsj
 tvn6aFivfjl/ElMv1mtQfN50yfW1c3vbj1RKcNxdVTbGKEP2+uMeMqRdHlehrWiPr/RB
 jvJUgu/9ZeGfG/HLFTR+LASCwJMUEltxd0Y/oC1AmOdVD3C9QT3rDIxgk7C9oQduXqwL jA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfbpe8dfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 22:39:28 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30VMQvtH020712;
        Tue, 31 Jan 2023 22:39:27 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfbpe8dfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 22:39:27 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30VLaEOb025857;
        Tue, 31 Jan 2023 22:39:26 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3ncvtrq1bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 22:39:26 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30VMdNlc2425418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 22:39:23 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E0E458052;
        Tue, 31 Jan 2023 22:39:23 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E9095804E;
        Tue, 31 Jan 2023 22:39:22 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jan 2023 22:39:22 +0000 (GMT)
Message-ID: <deec5230-b72e-3325-3dfc-fb8c818526a4@linux.ibm.com>
Date:   Tue, 31 Jan 2023 17:39:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH ima-evm-utils v2] Add tests for MMAP_CHECK and
 MMAP_CHECK_REQPROT hooks
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        pvorel@suse.cz, Roberto Sassu <roberto.sassu@huawei.com>
References: <20230131174245.2343342-1-roberto.sassu@huaweicloud.com>
 <20230131174245.2343342-3-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230131174245.2343342-3-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jtRuxiSHqkKzwTNNpi6FBqSTWrNRJ_M4
X-Proofpoint-GUID: ES69wqk_a3WYrbbLU1p5ub7BMnnA1Ns4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301310195
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 1/31/23 12:42, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 


> +check_mmap() {
> +	local hook="$1"
> +	local arg="$2"
> +	local test_file fowner rule result test_file_entry
> +
> +	echo -e "\nTest: ${FUNCNAME[0]} (hook=\"$hook\", test_mmap arg: \"$arg\")"
> +
> +	if ! test_file=$(mktemp -p "$PWD"); then
> +		echo "${RED}Cannot write $test_file${NORM}"
> +		return "$HARDFAIL"
> +	fi
> +
> +	fowner="$MMAP_CHECK_FOWNER"
> +	rule="$MEASURE_MMAP_CHECK_RULE"
> +
> +	if [ "$hook" = "MMAP_CHECK_REQPROT" ]; then
> +		fowner="$MMAP_CHECK_REQPROT_FOWNER"
> +		rule="$MEASURE_MMAP_CHECK_REQPROT_RULE"
> +	fi
> +
> +	if ! chown "$fowner" "$test_file"; then
> +		echo "${RED}Cannot change owner of $test_file${NORM}"
> +		return "$HARDFAIL"
> +	fi
> +
> +	check_load_ima_rule "$rule"
> +	result=$?
> +	if [ $result -ne "$OK" ]; then
> +		return $result
> +	fi
> +
> +	test_mmap "$test_file" "$arg"

In this case it should succeed or fail depending on the $rule?  I am just wondering whether to check $? here as well for expected outcome...

> +
> +	if [ "$TFAIL" != "yes" ]; then
> +		echo -n "Result (expect found): "
> +	else
> +		echo -n "Result (expect not found): "
> +	fi
> +
> +	test_file_entry=$(awk '$5 == "'"$test_file"'"' < /sys/kernel/security/ima/ascii_runtime_measurements)
> +	if [ -z "$test_file_entry" ]; then
> +		echo "not found"
> +		return "$FAIL"
> +	fi
> +
> +	echo "found"
> +	return "$OK"
> +}

> +if [ -n "$TST_KEY_PATH" ]; then
> +	if [ "${TST_KEY_PATH:0:1}" != "/" ]; then
> +		echo "${RED}Absolute path required for the signing key${NORM}"
> +		exit "$FAIL"
> +	fi
> +
> +	if [ ! -f "$TST_KEY_PATH" ]; then
> +		echo "${RED}Kernel signing key not found in $TST_KEY_PATH${NORM}"
> +		exit "$FAIL"
> +	fi
> +
> +	key_path="$TST_KEY_PATH"

g_key_path ? or pass as parameter to check_deny (better IMO)

> +elif [ -f "$PWD/../signing_key.pem" ]; then
> +	key_path="$PWD/../signing_key.pem"
> +elif [ -f "/lib/modules/$(uname -r)/source/certs/signing_key.pem" ]; then
> +	key_path="/lib/modules/$(uname -r)/source/certs/signing_key.pem"
> +elif [ -f "/lib/modules/$(uname -r)/build/certs/signing_key.pem" ]; then
> +	key_path="/lib/modules/$(uname -r)/build/certs/signing_key.pem"
> +else
> +	echo "${CYAN}Kernel signing key not found${NORM}"
> +	exit "$SKIP"
> +fi
> +
> +key_path_der=$(mktemp)

g_key_path_der for consistency

> +++ b/tests/test_mmap.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
> + *
> + * Tool to test IMA MMAP_CHECK and MMAP_CHECK_REQPROT hooks.
> + */
> +#include <stdio.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/stat.h>
> +#include <sys/mman.h>
> +#include <sys/personality.h>
> +
> +int main(int argc, char *argv[])
> +{
> +	struct stat st;
> +	void *ptr, *ptr_write = NULL;
> +	int ret, fd, fd_write, prot = PROT_READ;
> +
> +	if (!argv[1])
> +		return -ENOENT;
> +
> +	if (argv[2] && !strcmp(argv[2], "read_implies_exec")) {
> +		ret = personality(READ_IMPLIES_EXEC);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	if (stat(argv[1], &st) == -1)
> +		return -errno;
> +
> +	if (argv[2] && !strcmp(argv[2], "exec_on_writable")) {
> +		fd_write = open(argv[1], O_RDWR);
> +		if (fd_write == -1)
> +			return -errno;
> +
> +		ptr_write = mmap(0, st.st_size, PROT_WRITE, MAP_SHARED,
> +				 fd_write, 0);
> +		close(fd_write);
> +
> +		if (ptr_write == (void *)-1)
> +			return -errno;
> +	}
> +
> +	fd = open(argv[1], O_RDONLY);
> +	if (fd == -1) {
> +		if (ptr_write)
> +			munmap(ptr_write, st.st_size);
> +
> +		return -errno;
> +	}
> +
> +	if (argv[2] && !strncmp(argv[2], "exec", 4))
> +		prot |= PROT_EXEC;
> +
> +	ptr = mmap(0, st.st_size, prot, MAP_PRIVATE, fd, 0);
> +
> +	close(fd);
> +
> +	if (ptr_write)
> +		munmap(ptr_write, st.st_size);
> +
> +	if (ptr == (void *)-1)
> +		return -errno;
> +
> +	ret = 0;
> +
> +	if (argv[2] && !strcmp(argv[2], "mprotect"))
> +		ret = mprotect(ptr, st.st_size, PROT_EXEC);
> +
> +	munmap(ptr, st.st_size);
> +	return ret;
> +}

Are there any unexpected failure cases here where it should report an error to the user?

    Stefan
