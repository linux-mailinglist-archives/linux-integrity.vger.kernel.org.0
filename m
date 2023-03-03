Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CB46A8E78
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Mar 2023 02:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjCCBEn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Mar 2023 20:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCCBEn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Mar 2023 20:04:43 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3711B3E09B
        for <linux-integrity@vger.kernel.org>; Thu,  2 Mar 2023 17:04:42 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3230v9nH009459;
        Fri, 3 Mar 2023 01:04:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=sleqTtULt6bjITmKyTy80hL2r2xO8rYgJCVBPumQel8=;
 b=m5ztyFGdI5A1RiS3KGw0q1E9BRhURbamYQHa6s2tT+riTBpcJRXt8/95afO+BQUfRrN9
 iFvjeke3+DEFoZkyYzcEkRnZY5xxoiyKANfyimVVIVj4Sc5lPoU9VQ54FtXNw8X0PYEa
 AC1mjIi8YOPwBKEpeiBb88VV8447Gd1rJEocjL3yx7OiXQe3cwZ20yNoWFmHJMhkE5D1
 8zMa2WW53d9hq9samBLGZ057+02zAKtPX0UY/i2Ua2rGb5MHfFU8+M9Sr5Z1N9vZcQwG
 YKghVNjkh8iswgMCs1z3SPbVly8lKLkxDRn8sn9viDiBZwhB9iV4iIllPLIz/pVHJ3JI sA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p36e90n8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 01:04:21 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3230vNM2010456;
        Fri, 3 Mar 2023 01:04:20 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p36e90n7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 01:04:20 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3230EFvb016107;
        Fri, 3 Mar 2023 01:04:20 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3nybdm7tgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 01:04:20 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32314IRV3277478
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Mar 2023 01:04:19 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA61F5805F;
        Fri,  3 Mar 2023 01:04:18 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D232258059;
        Fri,  3 Mar 2023 01:04:17 +0000 (GMT)
Received: from sig-9-65-202-48.ibm.com (unknown [9.65.202.48])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  3 Mar 2023 01:04:17 +0000 (GMT)
Message-ID: <2525a40a145cc51cf10d0b211ef9f58c9128482b.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v7] Add tests for MMAP_CHECK and
 MMAP_CHECK_REQPROT hooks
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 02 Mar 2023 20:04:17 -0500
In-Reply-To: <20230302180502.618368-1-roberto.sassu@huaweicloud.com>
References: <20230302180502.618368-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F3jV38I8QDo6MFMYqo4ftEvORgUgfUo-
X-Proofpoint-ORIG-GUID: tJ0kf1x1s1GWye2mz8HcFmDI15LkORD4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=865 phishscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030003
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-03-02 at 19:05 +0100, Roberto Sassu wrote:
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

Thanks, Roberto.  Both this and the ima_policy_check test are now
queued in next-testing.

-- 
thanks,

Mimi

