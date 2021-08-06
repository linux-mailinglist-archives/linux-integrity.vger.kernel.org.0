Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634883E2221
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Aug 2021 05:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242172AbhHFDUg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Aug 2021 23:20:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7578 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229458AbhHFDUf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Aug 2021 23:20:35 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17634Xxv030791;
        Thu, 5 Aug 2021 23:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Gv92TnluNfUfdqlDXrvWyiTsnjlFwKv1kG7Zm7PMzvs=;
 b=K4oo7G8zvdE/YQCikwRlomxctcy21Ku/ilde1iOXnApfhJwUEJIqOStF/d2v1iI+AUH2
 GNeNUzXZ3sDMfoe+/20dSC2l22N4H5ADMeE65UBZ4IioRCPl2JJRV2GBSytT3PCP4ZZR
 rAW66jwj1oEbya15PxRgYjkpFJDE7+cLHwqkK1wFvVJgVSyVY9GH3PWXlhZUDewLO8Na
 9k1htYkGEKrtgU37eoouxyWO+0v8Q7yBYt7Yg9/NIQHklf2T/9Mb/MH/UJUHk0m7Z47B
 RtvysEljDIt3mUaJ/4gSG65yh8vbuu7NBHx0vVjdQg79JetXMANZQsi5CZmzrs8kOEff 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a8q2yy4gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Aug 2021 23:19:52 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17634cMj031358;
        Thu, 5 Aug 2021 23:19:52 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a8q2yy4ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Aug 2021 23:19:51 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1763E5Hk032178;
        Fri, 6 Aug 2021 03:19:49 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3a4x594crh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Aug 2021 03:19:49 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1763Jkij50987374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Aug 2021 03:19:47 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9BA011C052;
        Fri,  6 Aug 2021 03:19:46 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0A0611C058;
        Fri,  6 Aug 2021 03:19:40 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.26.150])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 Aug 2021 03:19:40 +0000 (GMT)
Message-ID: <d85bfe88bb4abd06e47a36743f53d0610da0a259.camel@linux.ibm.com>
Subject: Re: [PATCH RFC v2 10/12] KEYS: link system_trusted_keys to
 mok_trusted_keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
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
        glin@suse.com, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Date:   Thu, 05 Aug 2021 23:19:39 -0400
In-Reply-To: <44ADB68B-4310-462B-96A8-2F69759BA2D8@oracle.com>
References: <20210726171319.3133879-1-eric.snowberg@oracle.com>
         <20210726171319.3133879-11-eric.snowberg@oracle.com>
         <6c751dadf4ce7385d0391ea26f1c7e4e910219e0.camel@linux.ibm.com>
         <44ADB68B-4310-462B-96A8-2F69759BA2D8@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DK3h-KN9gjkjfQ6rFdX3uWqOg8XJydjB
X-Proofpoint-ORIG-GUID: chi8FZeyI1ijZTb-eFW33FRARzMP7ZLz
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-06_01:2021-08-05,2021-08-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=846 spamscore=0 malwarescore=0
 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108060017
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-08-05 at 19:29 -0600, Eric Snowberg wrote:

> > From the thread discussion on 00/12:
> > 
> > Only the builtin keys should ever be on the builtin keyring.  The
> > builtin keyring would need to be linked to the mok keyring.  But in the
> > secondary keyring case, the mok keyring would be linked to the
> > secondary keyring, similar to how the builtin keyring is linked to the
> > secondary keyring.
> > 
> >        if (key_link(secondary_trusted_keys, builtin_trusted_keys) < 0)
> >                panic("Can't link trusted keyrings\n");
> 
> 
> This part is confusing me though.
> 
> Here are some of the tests I’m performing with the current series:
> 
> Initial setup:
> Create and enroll my own key into the MOK.
> Sign a kernel, kernel module and IMA key with my new CA key.
> Boot with lockdown enabled (to enforce sig validation).
> 
> Kernel built with CONFIG_SECONDARY_TRUSTED_KEYRING=y
> 
> $ keyctl show %:.secondary_trusted_keys
> Keyring
>  530463486 ---lswrv      0     0  keyring: .secondary_trusted_keys
>  411466727 ---lswrv      0     0   \_ keyring: .builtin_trusted_keys
>  979167715 ---lswrv      0     0   |   \_ asymmetric: Build time autogenerated kernel key: 07a56e29cfa1e21379aff2c522efff7d1963202a
>  534573591 ---lswrv      0     0   |   \_ asymmetric: Oracle-CA: Oracle certificate signing key: aeefb4bfde095cacaabff81dd266974b1b4e23b8
>  968109018 ---lswrv      0     0   \_ keyring: .mok
>  857795115 ---lswrv      0     0       \_ asymmetric: Erics-CA: UEK signing key: 9bfa6860483aa46bd83f7fa1289d9fc35799e93b
> 
> With this setup I can:
> * load a kernel module signed with my CA key
> * run "kexec -ls" with the kernel signed with my CA key
> * run "kexec -ls" with a kernel signed by a key in the platform keyring
> * load another key into the secondary trusted keyring that is signed by my CA key
> * load a key into the ima keyring, signed by my CA key
> 
> Kernel built without CONFIG_SECONDARY_TRUSTED_KEYRING defined
> 
> $ keyctl show %:.builtin_trusted_keys
> Keyring
>  812785375 ---lswrv      0     0  keyring: .builtin_trusted_keys
>  455418681 ---lswrv      0     0   \_ keyring: .mok
>  910809006 ---lswrv      0     0   |   \_ asymmetric: Erics-CA: UEK signing key: 9bfa6860483aa46bd83f7fa1289d9fc35799e93b
>  115345009 ---lswrv      0     0   \_ asymmetric: Oracle-CA: Oracle certificate signing key: aeefb4bfde095cacaabff81dd266974b1b4e23b8
>  513131506 ---lswrv      0     0   \_ asymmetric: Build time autogenerated kernel key: 22353509f203b55b84f15d0aadeddc134b646185
> 
> With this setup I can:
> * load a kernel module signed with my CA key
> * run "kexec -ls" with the kernel signed with my CA key
> * run "kexec -ls" with a kernel signed by a key in the platform keyring
> * load a key into the ima keyring, signed by my CA key
> 
> So why would the linking need to be switched?  Is there a test I’m
> missing?  Thanks.

It's a question of semantics.  The builtin keyring name is self
describing.  It should only contain the keys compiled into the kernel
or inserted post build into the reserved memory.  Not only the kernel
uses the builtin keyring, but userspace may as well[1].  Other users of
the builtin keyring might not want to trust the mok keyring as well.

thanks,

Mimi

[1] Refer to Mat Martineau's LSS 2019 talk titled "Using and
Implementing Keyring Restrictions in Userspace". 

