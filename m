Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFBE683AD9
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Feb 2023 01:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjBAAAb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Jan 2023 19:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjBAAAa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Jan 2023 19:00:30 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634FA903D;
        Tue, 31 Jan 2023 16:00:29 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VMlfwp017012;
        Wed, 1 Feb 2023 00:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=47RuRwySVmTMFFl54aMpaViCwmyYhYq34ZYUAVPjLlA=;
 b=TUYwTfpBqcOXSeJCvjEhFXq17beYJXERCbvz4rOLQIbjcCT+1ZP2A/4fhA9uK8tBljN5
 e2J1kh34fPczrwFH2j5bkt001hPU1vDU6wWUqa+gnU2Ufe6MNb0JfsTLbF6ZGBoeT4mn
 49W/bsTbCdTN2bpGV+Hm4ZHo8QiMa9tdNv7gAhl3/J/dmBuevOYkoUz/Z0qkSfKXihr6
 F34x/NdpRK5k1D3zNAyG9Gg6clNyQDFWLQIoniQZN9upG0DWi0PIrRwIqFzVsWZXVjiB
 sxU/FMYUMlz/FNrgXVzECjYK4TY1C45Po83SX4m5CHpvs+E6x/iZZIfyjcNh4EDGs6vH zA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfag0bh5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 00:00:13 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30VNqBJe005831;
        Wed, 1 Feb 2023 00:00:12 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfag0bh4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 00:00:12 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30VMYW1k007780;
        Wed, 1 Feb 2023 00:00:11 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3ncvtetrag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 00:00:11 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31100Ai729557168
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Feb 2023 00:00:10 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D69C58061;
        Wed,  1 Feb 2023 00:00:10 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87B3B5805A;
        Wed,  1 Feb 2023 00:00:09 +0000 (GMT)
Received: from sig-9-77-155-214.ibm.com (unknown [9.77.155.214])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  1 Feb 2023 00:00:09 +0000 (GMT)
Message-ID: <6a98beea4607a9684789e862b4182dfdf3bec8de.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v2] Add tests for MMAP_CHECK and
 MMAP_CHECK_REQPROT hooks
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanb@linux.ibm.com,
        viro@zeniv.linux.org.uk, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Tue, 31 Jan 2023 19:00:09 -0500
In-Reply-To: <20230131174245.2343342-3-roberto.sassu@huaweicloud.com>
References: <20230131174245.2343342-1-roberto.sassu@huaweicloud.com>
         <20230131174245.2343342-3-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: adHO93F_tAE9m5qYBJLmFb3SUv_jYlNi
X-Proofpoint-ORIG-GUID: dn5BI28q1kg3csdIGl3tFd01l0iJV54i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301310202
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-01-31 at 18:42 +0100, Roberto Sassu wrote:
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

Nice!   Including some comments, or at least the test assumption, would
help simplify reviewing the code.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

