Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BE9324374
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Feb 2021 19:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhBXSBs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Feb 2021 13:01:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41296 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229498AbhBXSBr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Feb 2021 13:01:47 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11OHYUs6186082;
        Wed, 24 Feb 2021 13:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=7/iyiJqTTQ43euepQ5R46rfta0qytW9mHq3cQkcFOhA=;
 b=rycovHuMHxJOBJiHGINaW215vwFddh/3XjJ3NlhVfmNwgH3+V94yGQzuPUJG7B2u2Z+L
 Cw+s0JoSp07NaASebApB361naIz5s8+ZiGrWx/GgfP2ECACHfLL/hIbH7a8uri7JnuzO
 ed4G7+jifQiWp0uUZzoLcvASqEM3tAuN6jRHijX/YmQCy5THYtTqNiEDtr2070ShmJAf
 nQaWeRZw0X5ShdJTKxoW6qoe2IPronybjHE7m8yHc4R3gb8LmF4eKqvJuEz5zrTpbfvM
 wm7hK6/UT2CYMMhysYvwTWVGoTsbdksdASUIP3u2817t/y6vgod8IdZ2f+7qlDB7A6lR vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36wmac1r3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 13:00:59 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11OHale5005505;
        Wed, 24 Feb 2021 13:00:58 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36wmac1r32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 13:00:58 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11OHvRdI016687;
        Wed, 24 Feb 2021 18:00:57 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01dal.us.ibm.com with ESMTP id 36tt2a0mb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 18:00:57 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11OI0uN438797644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 18:00:56 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8678778063;
        Wed, 24 Feb 2021 18:00:56 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98E897805F;
        Wed, 24 Feb 2021 18:00:54 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.80.227.153])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 24 Feb 2021 18:00:54 +0000 (GMT)
Message-ID: <b0c4980c8fad14115daa3040979c52f07f7fbe2c.camel@linux.ibm.com>
Subject: Re: [PATCH 2/9] tpm: Allow PCR 23 to be restricted to kernel-only
 use
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Matthew Garrett <matthewgarrett@google.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org, zohar@linux.ibm.com, jarkko@kernel.org,
        corbet@lwn.net, rjw@rjwysocki.net,
        Matthew Garrett <mjg59@google.com>
Date:   Wed, 24 Feb 2021 10:00:53 -0800
In-Reply-To: <20210220013255.1083202-3-matthewgarrett@google.com>
References: <20210220013255.1083202-1-matthewgarrett@google.com>
         <20210220013255.1083202-3-matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-24_08:2021-02-24,2021-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102240137
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2021-02-20 at 01:32 +0000, Matthew Garrett wrote:
> Under certain circumstances it might be desirable to enable the
> creation of TPM-backed secrets that are only accessible to the
> kernel. In an ideal world this could be achieved by using TPM
> localities, but these don't appear to be available on consumer
> systems.

I don't understand this ... the localities seem to work fine on all the
systems I have ... is this some embedded thing?

>  An alternative is to simply block userland from modifying one of the
> resettable PCRs, leaving it available to the kernel. If the kernel
> ensures that no userland can access the TPM while it is carrying out
> work, it can reset PCR 23, extend it to an arbitrary value, create or
> load a secret, and then reset the PCR again. Even if userland somehow
> obtains the sealed material, it will be unable to unseal it since PCR
> 23 will never be in the appropriate state.

This seems a bit arbitrary: You're removing this PCR from user space
accessibility, but PCR 23 is defined as "Application Support" how can
we be sure no application will actually want to use it (and then fail)?

Since PCRs are very scarce, why not use a NV index instead.  They're
still a bounded resource, but most TPMs have far more of them than they
do PCRs, and the address space is much bigger so picking a nice
arbitrary 24 bit value reduces the chance of collisions.

James


