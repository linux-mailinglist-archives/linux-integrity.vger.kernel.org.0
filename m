Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3139E68BE78
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Feb 2023 14:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjBFNle (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Feb 2023 08:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjBFNld (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Feb 2023 08:41:33 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9620B358B;
        Mon,  6 Feb 2023 05:41:32 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316DC4oK009616;
        Mon, 6 Feb 2023 13:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=2nSNHaV5e1IHmiQtcHO3Jiq++ilmeDH0Trbioxr0Xow=;
 b=pzAhh+dMojlmKCV3T3bvQQjHXAKNfVQvXZGDXJGcU44vVK/S1ZNhsnZO3Pe7dAA2r9V1
 OeKjbvxVLXEeDH9Gr3uUfElQTwnzrRWmm90EAEFLPgN0aTneIIwdnbBKunnw4AuHqSqY
 DJjDJMsod5fnG/24vZb9ujE/Yu4Vm0/PJuFbntYwDcT4JyfZe3TRfq1ICSq/+khaUFc6
 2fyY1sX2DzjE6GDjRFSuFUFpxxlLvH0AdjgSsxjsHM5ltJqdRz/8ZmGJUvvwV5nVX/8F
 NjTdT4ptWmQ+mq6U++VtvS6OnLxOQMw9BFzBD4fsOTZpUL177k9FKihO4xpG/WGblXjT pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk27m86mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 13:20:21 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316DE1Jo014862;
        Mon, 6 Feb 2023 13:20:21 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk27m86m5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 13:20:21 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 316C3Dh5003016;
        Mon, 6 Feb 2023 13:20:20 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3nhf07dgvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 13:20:20 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 316DKId528443134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 13:20:19 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97C065803F;
        Mon,  6 Feb 2023 13:20:18 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40FF45805A;
        Mon,  6 Feb 2023 13:20:17 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.5.191])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Feb 2023 13:20:17 +0000 (GMT)
Message-ID: <cd21f0d2a65f9673a0abe7f0a7219d5f1fe55911.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v5] Add tests for MMAP_CHECK and
 MMAP_CHECK_REQPROT hooks
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanb@linux.ibm.com,
        viro@zeniv.linux.org.uk, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 06 Feb 2023 08:20:16 -0500
In-Reply-To: <20230203125637.2673781-1-roberto.sassu@huaweicloud.com>
References: <20230203125637.2673781-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: I6xQxEYudUHGl0zpX_fuX4iRH-Xi8FT6
X-Proofpoint-GUID: ySyBf7OxOaSh6fMWQubB9JecQqUTi_PK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_06,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=945 malwarescore=0
 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302060111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2023-02-03 at 13:56 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Add tests to ensure that, after applying the kernel patch 'ima: Align
> ima_file_mmap() parameters with mmap_file LSM hook', the MMAP_CHECK hook
> checks the protections applied by the kernel and not those requested by the
> application.
> 
> Also ensure that after applying 'ima: Introduce MMAP_CHECK_REQPROT hook',
> the MMAP_CHECK_REQPROT hook checks the protections requested by the
> application.
> 
> Test both with the test_mmap application that by default requests the
> PROT_READ protection flag. Its syntax is:
> 
> test_mmap <file> <mode>
> 
> where mode can be:
> - exec: adds the PROT_EXEC protection flag to mmap()
> - read_implies_exec: calls the personality() system call with
>                      READ_IMPLIES_EXEC as the first argument before mmap()
> - mprotect: adds the PROT_EXEC protection flag to a memory area in addition
>             to PROT_READ
> - exec_on_writable: calls mmap() with PROT_EXEC on a file which has a
>                     writable mapping
> 
> Check the different combinations of hooks/modes and ensure that a
> measurement entry is found in the IMA measurement list only when it is
> expected. No measurement entry should be found when only the PROT_READ
> protection flag is requested or the matching policy rule has the
> MMAP_CHECK_REQPROT hook and the personality() system call was called with
> READ_IMPLIES_EXEC.
> 
> mprotect() with PROT_EXEC on an existing memory area protected with
> PROT_READ should be denied (with an appraisal rule), regardless of the MMAP
> hook specified in the policy. The same applies for mmap() with PROT_EXEC on
> a file with a writable mapping.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks, Roberto.  Other than the one comment below, it looks good.

> +
> +if ! awk '$0 ~ /^(measure|appraise)/ && $0 !~ /fsuuid=/ && $0 !~ /fowner=/ { exit 1 }' < /sys/kernel/security/ima/policy; then
> +	echo "${CYAN}IMA policy rules without fsuuid= and fowner=, cannot continue due to possible interference with the tests${NORM}"
> +	exit "$SKIP"
> +fi

The test should be limited to just MMAP_CHECK and MMAP_CHECK_REQPROT
policy rules.

+if ! awk '$0 ~ /^(measure|appraise)/ && $0 ~ /func=MMAP_CHECK/ && $0 !~ /fsuuid=/ && ...

Mimi

