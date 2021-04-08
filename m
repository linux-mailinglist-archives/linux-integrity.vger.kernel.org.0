Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9F6358CBD
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Apr 2021 20:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhDHSeY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Apr 2021 14:34:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232840AbhDHSeY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Apr 2021 14:34:24 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 138IXcH3128324;
        Thu, 8 Apr 2021 14:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=2C5gYa9A38m9IvkCgL/lr+p18uGf81bWHt/F76g28uY=;
 b=gGK65zhzT8y9dhIf5ncZ2Vxx1Gi7DMg0YN+U7XAXtguMFKgzS3SDT3Xb+glWBKfb8jHo
 Q2OF8HZ+WCOzWkXTeLrNkApIOPUegA5Tfa6jtiCPyoDDLRomYcoSc6tgvDQNwA8tZqrM
 NECTt/RnEUFx4AEqwOROX0lRp38lJt/KddO0uOGIjhl/jOTx3K2sHeS+fiV61y1ztQJ7
 f+QxAl9x4sezD7+rC/NKntL6N87lNbm3GSJ/vglVdGMN86RarMY4CNnGLC6nbcJCrXCE
 av/SQAoLCx1YvPcD1DqS4NXkIpaabithFFsqZZIG9XdX3VhSWfaInjzJ/jj15O4nuTZf qQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rw7ksb1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 14:34:08 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 138IXLVu030168;
        Thu, 8 Apr 2021 18:34:06 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 37rvbu9tju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 18:34:06 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 138IY4Nb23462360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Apr 2021 18:34:04 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 064DBA4059;
        Thu,  8 Apr 2021 18:34:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAC8DA406E;
        Thu,  8 Apr 2021 18:34:02 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.65.12])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  8 Apr 2021 18:34:02 +0000 (GMT)
Message-ID: <7fd27dca4e21e2c8481fadb0281e14f06f7f1eb7.camel@linux.ibm.com>
Subject: Re: Question about the available tests for IMA apprise
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Fan Wu <wufan@linux.microsoft.com>, pvorel@suse.cz
Cc:     linux-integrity@vger.kernel.org
Date:   Thu, 08 Apr 2021 14:34:01 -0400
In-Reply-To: <cb6ed68b-3f4a-2a4e-9010-0e385af5b7d4@linux.microsoft.com>
References: <cb6ed68b-3f4a-2a4e-9010-0e385af5b7d4@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NpXcCTydMYKWufFWiXfHB36F-OXkf_Ak
X-Proofpoint-ORIG-GUID: NpXcCTydMYKWufFWiXfHB36F-OXkf_Ak
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-08_04:2021-04-08,2021-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104080122
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-04-01 at 17:12 -0700, Fan Wu wrote:
> Hello,
> 
> We are trying to extend the IMA apprise action. To prevent breaking the 
> system, we want to collect existing apprise-related tests, but I find 
> there are not many tests related in the LTP project.
> 
> As far as I am aware, only evm_overlay and kexec tests are testing with 
> a policy that contains a apprise rule. But they do not test the file 
> execution (exec/mmap/mproject syscalls with various args) we are 
> focusing on.
> 
> I am wondering, are all available tests in the LTP? Also, I am looking 
> for suggestions for testing apprise.

Right.  By "appraise", I assume you mean signed files.  Until file data
and metadata are distributed together, the public key is loaded onto
the IMA keyring, and an appropriate IMA policy is loaded, generic
"appraise" testing is kind of difficult.

Distro kernel images is an exception as they are signed, the associated
public key may be loaded on the platform keyring, and the IMA arch
specific policies define IMA policy rules that require the kernel image
to be signed, with all of this in place there are kexec tests.

Once Nayna's "ima: kernel build support for loading the kernel module
signing key" patch set, generic kernel module tests could be written as
well.

In general, if additional IMA appraise policy rules need to be loaded,
they need to be limited to the test environment to avoid affecting the
running system.  For example, both LTP and bpf IMA policy rules are
limited to the loopback mounted filesystems.

If you know how to generically solve the above requirements, adding
additional "appraise" tests would be very welcome.

thanks,

Mimi

