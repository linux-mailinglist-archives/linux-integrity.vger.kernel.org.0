Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F8841A15A
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Sep 2021 23:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237162AbhI0VdQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Sep 2021 17:33:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19304 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237080AbhI0VdP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Sep 2021 17:33:15 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18RJHp8D014340;
        Mon, 27 Sep 2021 17:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=k5pSmabzJ/jLB77q+k/cXqSjGk77BXqY5MkTCxaO+Ac=;
 b=mTMh7Qyt6xOyJ4tioWk45qqtQXI1p1k9WoWlzYqanxFE4JtjWJTInMlY4+BJU/EJJiW/
 oUNAyLx4N9E0OewgbxpfnfYJBTwE6QYkkF77zJ6o1+NGt4wmhlcQCtiBp4lRe82NZ9zr
 2TXTQ+GWpsGMi4pGruOjAylwzLcciu8Mm6WMFz9FyjNgx3/QjDMrq9mSRw4Xe2klpF8N
 Kf9GSKdflShmL+14HDsEOHiWBpfc7Tm4LpvtC3579WkAMJg0/ytdqpY0yvIQ6C0VpJpL
 AD9546HGjHq9veUPo99/m4cr+OWGixUQmFus55uPrMA8WsIuFnMYJhR3Kwx8il6uCuy7 Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bagsf4s0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Sep 2021 17:31:19 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18RLKDaW010246;
        Mon, 27 Sep 2021 17:31:18 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bagsf4ryy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Sep 2021 17:31:18 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18RLRqvQ023437;
        Mon, 27 Sep 2021 21:31:16 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3b9ud9f0ks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Sep 2021 21:31:16 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18RLQE3x60752354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Sep 2021 21:26:14 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88373A404D;
        Mon, 27 Sep 2021 21:31:13 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CA8CA4053;
        Mon, 27 Sep 2021 21:31:10 +0000 (GMT)
Received: from sig-9-65-205-158.ibm.com (unknown [9.65.205.158])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Sep 2021 21:31:10 +0000 (GMT)
Message-ID: <81602197662f3e6d032103bd1ac3690342544b7e.camel@linux.ibm.com>
Subject: Re: [PATCH v3] KEYS: trusted: Fix trusted key backends when
 building as module
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Andreas Rammhold <andreas@rammhold.de>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 27 Sep 2021 17:31:09 -0400
In-Reply-To: <20210927205521.7c4psu4vz5eoyfnf@wrt>
References: <20210730012822.3460913-1-andreas@rammhold.de>
         <0d42a11a-0117-49a9-d2c9-bc6cc405235d@pengutronix.de>
         <20210927085104.vq42feghtaqiv6ni@wrt>
         <856359f263575f01d0ce2fcf8f042321f750b38c.camel@linux.ibm.com>
         <20210927200835.wvazk73cek3t5tkf@wrt>
         <2ad2c536367028ef6d9300745586a123cb13d9f1.camel@linux.ibm.com>
         <20210927205521.7c4psu4vz5eoyfnf@wrt>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Jsy6neKp07vSqvK7YDa1VbLEN3mHF1hQ
X-Proofpoint-ORIG-GUID: yJhI9PlJpxzmIMDFEajSlCt1pYvSuTUr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-27_07,2021-09-24_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 mlxscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109270144
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-09-27 at 22:55 +0200, Andreas Rammhold wrote:
> On 16:33 27.09.21, Mimi Zohar wrote:
> > On Mon, 2021-09-27 at 22:08 +0200, Andreas Rammhold wrote:
> > > On 07:27 27.09.21, Mimi Zohar wrote:
> > > > On Mon, 2021-09-27 at 10:51 +0200, Andreas Rammhold wrote:
> > > > > On 09:47 13.09.21, Ahmad Fatoum wrote:
> > > > > > Dear trusted key maintainers,
> > > > > > 
> > > > > > On 30.07.21 03:28, Andreas Rammhold wrote:
> > > > > > > Before this commit the kernel could end up with no trusted key sources
> > > > > > > even though both of the currently supported backends (TPM and TEE) were
> > > > > > > compiled as modules. This manifested in the trusted key type not being
> > > > > > > registered at all.
> > > > > > > 
> > > > > > > When checking if a CONFIG_… preprocessor variable is defined we only
> > > > > > > test for the builtin (=y) case and not the module (=m) case. By using
> > > > > > > the IS_REACHABLE() macro we do test for both cases.
> > > > > > > 
> > > > > > > Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> > > > > > > Signed-off-by: Andreas Rammhold <andreas@rammhold.de>
> > > > > > > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > > > Does anyone intend to pick this up?
> > > > > 
> > > > > Did this end up in any tree by now? I am wondering if I should resend
> > > > > the patch instead. Perhaps it was just overlooked?
> > > > 
> > > > For EVM environments only using trusted and encrypted keys, not file
> > > > signatures, the trusted key is needed to decrypt the "master" key in
> > > > order to verify kernel modules.
> > > 
> > > So what you are saying is that right now (before this patch & after this
> > > patch) you could compile a kernel that wouldn't be able to load any
> > > modules when the trusted keychain part is built as module?
> > 
> > Before this patch, trusted and encrypted keys are builtin, so verifying
> > kernel modules with security.evm containing an EVM hmac would succeed. 
> > Afterwards it would fail, as there's a dependency on the trusted key to
> > verify the integrity of the trusted key module.
> 
> But building with =m was a valid configuration which is the original
> reason for me submitting the patch. So perhaps this should not be
> allowed to be a module then?

My mistake.  Trusted and encrypted key types have always been defined
as tristate.  Only when EVM selects encrypted keys, and by extension
trusted keys, are they builtin.

Mimi

