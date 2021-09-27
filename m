Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516F241A030
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Sep 2021 22:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbhI0UfF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Sep 2021 16:35:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33788 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235825AbhI0UfE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Sep 2021 16:35:04 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18RJqUxv022830;
        Mon, 27 Sep 2021 16:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=TQeTvl1sCZgN17R8XLCze71ArJ1lADmQApHk/gp8lOs=;
 b=c0ZEdAqwqT0SNp8Rpe77hm8+Xb7A6Dxq/r1VtvImyEyEQChsyjL+Hw4OxDh3pxwTMBCS
 VsVJq5T2kiGcOaav7A6T+DIVyH29LnvPpEDpBg9f4nIPcKXVgJ4KJrAqCd8XcpN2ENIW
 cbyUnDHbBAYgeLaEAr2g3SJ+w0mPpm83ZGQeT1nv4PZx4Qas8xAj2fjC9LP9rBmprH0x
 LIcvPJCvHmr1LjtSrr58xuLuGG84pK7xA6+H7dCxoMRofXCJaroFEMctam58tKCNN6BG
 LslR4evEYLvnjQYwYEUGZabKghyiUbxlF2cvXrMcUZIGuIv8+1tYBkygixkYlZpoZ3Xe yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bbarkdhs3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Sep 2021 16:33:17 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18RKVYKd017768;
        Mon, 27 Sep 2021 16:33:16 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bbarkdhrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Sep 2021 16:33:16 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18RKXEB1029181;
        Mon, 27 Sep 2021 20:33:14 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3b9u1jpv0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Sep 2021 20:33:14 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18RKSCDL60752232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Sep 2021 20:28:12 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 523384C044;
        Mon, 27 Sep 2021 20:33:11 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2082D4C046;
        Mon, 27 Sep 2021 20:33:09 +0000 (GMT)
Received: from sig-9-65-205-158.ibm.com (unknown [9.65.205.158])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Sep 2021 20:33:08 +0000 (GMT)
Message-ID: <2ad2c536367028ef6d9300745586a123cb13d9f1.camel@linux.ibm.com>
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
Date:   Mon, 27 Sep 2021 16:33:08 -0400
In-Reply-To: <20210927200835.wvazk73cek3t5tkf@wrt>
References: <20210730012822.3460913-1-andreas@rammhold.de>
         <0d42a11a-0117-49a9-d2c9-bc6cc405235d@pengutronix.de>
         <20210927085104.vq42feghtaqiv6ni@wrt>
         <856359f263575f01d0ce2fcf8f042321f750b38c.camel@linux.ibm.com>
         <20210927200835.wvazk73cek3t5tkf@wrt>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RpneFkB6zSNRp72dFR07tofCoOeFpWrG
X-Proofpoint-GUID: JGBpei9WkLffA_dDqOvc7zOKxQCrAyRJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-27_07,2021-09-24_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 malwarescore=0 mlxscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109270138
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-09-27 at 22:08 +0200, Andreas Rammhold wrote:
> On 07:27 27.09.21, Mimi Zohar wrote:
> > On Mon, 2021-09-27 at 10:51 +0200, Andreas Rammhold wrote:
> > > On 09:47 13.09.21, Ahmad Fatoum wrote:
> > > > Dear trusted key maintainers,
> > > > 
> > > > On 30.07.21 03:28, Andreas Rammhold wrote:
> > > > > Before this commit the kernel could end up with no trusted key sources
> > > > > even though both of the currently supported backends (TPM and TEE) were
> > > > > compiled as modules. This manifested in the trusted key type not being
> > > > > registered at all.
> > > > > 
> > > > > When checking if a CONFIG_… preprocessor variable is defined we only
> > > > > test for the builtin (=y) case and not the module (=m) case. By using
> > > > > the IS_REACHABLE() macro we do test for both cases.
> > > > > 
> > > > > Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> > > > > Signed-off-by: Andreas Rammhold <andreas@rammhold.de>
> > > > > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > Does anyone intend to pick this up?
> > > 
> > > Did this end up in any tree by now? I am wondering if I should resend
> > > the patch instead. Perhaps it was just overlooked?
> > 
> > For EVM environments only using trusted and encrypted keys, not file
> > signatures, the trusted key is needed to decrypt the "master" key in
> > order to verify kernel modules.
> 
> So what you are saying is that right now (before this patch & after this
> patch) you could compile a kernel that wouldn't be able to load any
> modules when the trusted keychain part is built as module?

Before this patch, trusted and encrypted keys are builtin, so verifying
kernel modules with security.evm containing an EVM hmac would succeed. 
Afterwards it would fail, as there's a dependency on the trusted key to
verify the integrity of the trusted key module.

Mimi

