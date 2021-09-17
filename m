Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7900840FEEC
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Sep 2021 20:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239501AbhIQSEE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Sep 2021 14:04:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230115AbhIQSED (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Sep 2021 14:04:03 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18HHTsnv017258;
        Fri, 17 Sep 2021 14:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=6dl0XdISYgflLHA8V5h7HYVl7CaFpcLBWAuWqzylDms=;
 b=sTobmfwgVTNOV/NRtxCApV+FSlmKV5v/M3S9hvq3zHx0OPlo/PhPGm9HnC+1xLNFzOvi
 p/feHcH57Lf/MUuc9W0liRw7y51JFu1lVsg702HTyHC0qLmNoNQWzLBeKD6Iw7inKIrZ
 YL+OQN9yInH/Z9+KQmbuSeCrf+4x5fIVJW7ivxOBIw0aJZd2qNmJcbtWuuKZsl/eEH4N
 jx6Gw6AFwYYU0sG8qGZZF4skO+jGIF9k5lv4GuL03GXIOsqhB+YxVb0vCz6+tazIPWtQ
 hsvs7jciwTZ3h5kdgHnjD6M7HCDuf9FcmMYv9W5XMdzi306CunRPRfUu4qW1gxPQUI2A 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b4yf5gpkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Sep 2021 14:02:17 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18HHnpBA022627;
        Fri, 17 Sep 2021 14:02:16 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b4yf5gpj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Sep 2021 14:02:16 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18HHqYZ4014044;
        Fri, 17 Sep 2021 18:02:13 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3b0kqksh93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Sep 2021 18:02:13 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18HI2BsQ54329800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Sep 2021 18:02:11 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4403B11C05C;
        Fri, 17 Sep 2021 18:02:11 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A30BD11C06E;
        Fri, 17 Sep 2021 18:02:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.166.232])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 Sep 2021 18:02:06 +0000 (GMT)
Message-ID: <12efec9ce26b0f372653935379dc8ebfd6086804.camel@linux.ibm.com>
Subject: Re: [PATCH v6 00/13] Enroll kernel keys thru MOK
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>,
        Nayna <nayna@linux.vnet.ibm.com>
Cc:     keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Date:   Fri, 17 Sep 2021 14:02:05 -0400
In-Reply-To: <37D6AC4A-372D-497A-AF97-CEA03EFC9BBA@oracle.com>
References: <20210914211416.34096-1-eric.snowberg@oracle.com>
         <7e83a42f-22ff-350a-2017-d286b1b1b02c@linux.vnet.ibm.com>
         <37D6AC4A-372D-497A-AF97-CEA03EFC9BBA@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YXy4Tj_1a00UooTNj6_41O1SpLTr5v-1
X-Proofpoint-ORIG-GUID: ZrGZZcum32u3kchhxHKbi9J7MPo0oO7l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-17_07,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109170109
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-09-16 at 19:55 -0600, Eric Snowberg wrote:
> > On Sep 16, 2021, at 2:03 PM, Nayna <nayna@linux.vnet.ibm.com> wrote:
> > 
> > 
> > On 9/14/21 5:14 PM, Eric Snowberg wrote:
> >> Back in 2013 Linus requested a feature to allow end-users to have the
> >> ability "to add their own keys and sign modules they trust". This was
> >> his *second* order outlined here [1]. There have been many attempts
> >> over the years to solve this problem, all have been rejected.  Many
> >> of the failed attempts loaded all preboot firmware keys into the kernel,
> >> including the Secure Boot keys. Many distributions carry one of these
> >> rejected attempts [2], [3], [4]. This series tries to solve this problem
> >> with a solution that takes into account all the problems brought up in
> >> the previous attempts.
> >> 
> >> On UEFI based systems, this series introduces a new Linux kernel keyring
> >> containing the Machine Owner Keys (MOK) called machine. It also defines
> >> a new MOK variable in shim. This variable allows the end-user to decide
> >> if they want to load MOK keys into the machine keyring. Mimi has suggested
> >> that only CA keys contained within the MOK be loaded into the machine
> >> keyring. All other certs will load into the platform keyring instead.
> >> 
> >> By default, nothing changes; MOK keys are not loaded into the machine
> >> keyring.  They are only loaded after the end-user makes the decision
> >> themselves.  The end-user would set this through mokutil using a new
> >> --trust-mok option [5]. This would work similar to how the kernel uses
> >> MOK variables to enable/disable signature validation as well as use/ignore
> >> the db. Any kernel operation that uses either the builtin or secondary
> >> trusted keys as a trust source shall also reference the new machine
> >> keyring as a trust source.
> >> 
> >> Secure Boot keys will never be loaded into the machine keyring.  They
> >> will always be loaded into the platform keyring.  If an end-user wanted
> >> to load one, they would need to enroll it into the MOK.
> >> 
> >> Steps required by the end user:
> >> 
> >> Sign kernel module with user created key:
> >> $ /usr/src/kernels/$(uname -r)/scripts/sign-file sha512 \
> >>    machine_signing_key.priv machine_signing_key.x509 my_module.ko
> >> 
> >> Import the key into the MOK
> >> $ mokutil --import machine_signing_key.x509
> >> 
> >> Setup the kernel to load MOK keys into the .machine keyring
> >> $ mokutil --trust-mok
> >> 
> >> Then reboot, the MokManager will load and ask if you want to trust the
> >> MOK key and enroll the MOK into the MOKList.  Afterwards the signed kernel
> >> module will load.
> > 
> > machine_signing_key.x509 appears to be a code-signing, self-signed key.  It's not a CA key, but the intent of the patchset is to load only CA keys to .machine keyring.
> > 
> > Shouldn't there be two steps: one to load the CA key into MOK, and a second one to load the code-signing key which is signed by this CA ?
> 
> I think that would depend on how the end-user wants to do things. If they 
> are just looking to quickly self-sign their own kernel module, I doubt they 
> would go through the effort of having two keys.  This is what I tried to 
> document in the example above. 

Thank you for providing the example.  We've spent quite a bit of time
discussing CA keys stored in the MOK db being the new root(s) of trust.
While other certificates signed by the new root(s) of trust would be
added to the secondary or IMA keyrings.

At this point, the patch descriptions, and probably code, are written
in terms of CA keys stored in the MOK db, which the self signed
certificate restriction does not require.  With this design, these self
signed certs may be loaded directly onto the IMA keyring.  That's a
problem.  To fix the discrepancy between the cover letter, patch
descriptions and code, all that is needed is to verify that the self-
signed cert is in fact a CA.

thanks,

Mimi

