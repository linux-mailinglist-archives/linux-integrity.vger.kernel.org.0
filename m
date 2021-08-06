Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8519D3E2D72
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Aug 2021 17:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhHFPTh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Aug 2021 11:19:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55048 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232021AbhHFPTg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Aug 2021 11:19:36 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 176F4Voc189122;
        Fri, 6 Aug 2021 11:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=rgO1hBqZC57c2+Sv/vVXfN88h8j4+dvlSPH4nRvftfA=;
 b=Wka4jACSVCTnFGdewURKfL0kkFh0fdao526RdszASXCXY8NneaqPwj/U5PRt5TuayslZ
 Xsp9wE08uI4BP0XL1QDrBGkq+yCgU2VLGwDs4ggXQKqbDoWmc7fmMR0cNhKisrHUC+H5
 tw5fkwlkH4nz1uOo57IHYo/LcfZVbp7FkMVO1LEqutXzxC7sqQMz+vHyP3+YgV2JzDDo
 a4EnCxGpI3U3CoHmKcfx9eOv3WdN6rdJkCpf1PZ3XV7bRcMTnzDqB54lgSXv5bHBDwbl
 VXGojnwxcgFZo6QXApY+MkkAD26L+9B2/FC6OaMU4ZGdF/ge4fH+avlhUxDVVb4x+8zS 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a8j8j1spq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Aug 2021 11:18:43 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 176F5ADk004444;
        Fri, 6 Aug 2021 11:18:42 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a8j8j1snp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Aug 2021 11:18:42 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 176FIE6Z014168;
        Fri, 6 Aug 2021 15:18:40 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3a8dcqj4y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Aug 2021 15:18:40 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 176FIbdQ55378386
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Aug 2021 15:18:37 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4DF511C05B;
        Fri,  6 Aug 2021 15:18:37 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87BB111C05E;
        Fri,  6 Aug 2021 15:18:32 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.118.168])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 Aug 2021 15:18:32 +0000 (GMT)
Message-ID: <dc76d9463bb5e081d10154e909321b0d75391846.camel@linux.ibm.com>
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
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        lszubowi@redhat.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        glin@suse.com, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Date:   Fri, 06 Aug 2021 11:18:31 -0400
In-Reply-To: <21CB8F51-9066-4095-9C6E-428FF9E86443@oracle.com>
References: <20210726171319.3133879-1-eric.snowberg@oracle.com>
         <20210726171319.3133879-11-eric.snowberg@oracle.com>
         <6c751dadf4ce7385d0391ea26f1c7e4e910219e0.camel@linux.ibm.com>
         <44ADB68B-4310-462B-96A8-2F69759BA2D8@oracle.com>
         <d85bfe88bb4abd06e47a36743f53d0610da0a259.camel@linux.ibm.com>
         <21CB8F51-9066-4095-9C6E-428FF9E86443@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Udv4oSrDO2ieLhANn4kq7bqpT8Hrhvos
X-Proofpoint-ORIG-GUID: 365LpGflS7WoQs4sMb9ihzyLVcO8nzIM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-06_05:2021-08-05,2021-08-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108060104
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-08-06 at 09:00 -0600, Eric Snowberg wrote:
> > On Aug 5, 2021, at 9:19 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Thu, 2021-08-05 at 19:29 -0600, Eric Snowberg wrote:
> > 
> >>> From the thread discussion on 00/12:
> >>> 
> >>> Only the builtin keys should ever be on the builtin keyring.  The
> >>> builtin keyring would need to be linked to the mok keyring.  But in the
> >>> secondary keyring case, the mok keyring would be linked to the
> >>> secondary keyring, similar to how the builtin keyring is linked to the
> >>> secondary keyring.
> >>> 
> >>>       if (key_link(secondary_trusted_keys, builtin_trusted_keys) < 0)
> >>>               panic("Can't link trusted keyrings\n");
> >> 
> >> 
> >> This part is confusing me though.
> >> 
> >> Here are some of the tests I’m performing with the current series:
> >> 
> >> Initial setup:
> >> Create and enroll my own key into the MOK.
> >> Sign a kernel, kernel module and IMA key with my new CA key.
> >> Boot with lockdown enabled (to enforce sig validation).
> >> 
> >> Kernel built with CONFIG_SECONDARY_TRUSTED_KEYRING=y
> >> 
> >> $ keyctl show %:.secondary_trusted_keys
> >> Keyring
> >> 530463486 ---lswrv      0     0  keyring: .secondary_trusted_keys
> >> 411466727 ---lswrv      0     0   \_ keyring: .builtin_trusted_keys
> >> 979167715 ---lswrv      0     0   |   \_ asymmetric: Build time autogenerated kernel key: 07a56e29cfa1e21379aff2c522efff7d1963202a
> >> 534573591 ---lswrv      0     0   |   \_ asymmetric: Oracle-CA: Oracle certificate signing key: aeefb4bfde095cacaabff81dd266974b1b4e23b8
> >> 968109018 ---lswrv      0     0   \_ keyring: .mok
> >> 857795115 ---lswrv      0     0       \_ asymmetric: Erics-CA: UEK signing key: 9bfa6860483aa46bd83f7fa1289d9fc35799e93b
> >> 
> >> With this setup I can:
> >> * load a kernel module signed with my CA key
> >> * run "kexec -ls" with the kernel signed with my CA key
> >> * run "kexec -ls" with a kernel signed by a key in the platform keyring
> >> * load another key into the secondary trusted keyring that is signed by my CA key
> >> * load a key into the ima keyring, signed by my CA key
> >> 
> >> Kernel built without CONFIG_SECONDARY_TRUSTED_KEYRING defined
> >> 
> >> $ keyctl show %:.builtin_trusted_keys
> >> Keyring
> >> 812785375 ---lswrv      0     0  keyring: .builtin_trusted_keys
> >> 455418681 ---lswrv      0     0   \_ keyring: .mok
> >> 910809006 ---lswrv      0     0   |   \_ asymmetric: Erics-CA: UEK signing key: 9bfa6860483aa46bd83f7fa1289d9fc35799e93b
> >> 115345009 ---lswrv      0     0   \_ asymmetric: Oracle-CA: Oracle certificate signing key: aeefb4bfde095cacaabff81dd266974b1b4e23b8
> >> 513131506 ---lswrv      0     0   \_ asymmetric: Build time autogenerated kernel key: 22353509f203b55b84f15d0aadeddc134b646185
> >> 
> >> With this setup I can:
> >> * load a kernel module signed with my CA key
> >> * run "kexec -ls" with the kernel signed with my CA key
> >> * run "kexec -ls" with a kernel signed by a key in the platform keyring
> >> * load a key into the ima keyring, signed by my CA key
> >> 
> >> So why would the linking need to be switched?  Is there a test I’m
> >> missing?  Thanks.
> > 
> > It's a question of semantics.  The builtin keyring name is self
> > describing.  It should only contain the keys compiled into the kernel
> > or inserted post build into the reserved memory.  Not only the kernel
> > uses the builtin keyring, but userspace may as well[1].  Other users of
> > the builtin keyring might not want to trust the mok keyring as well.
> 
> Should this feature only work with kernels built with 
> CONFIG_SECONDARY_TRUSTED_KEYRING defined?  If so, I could drop support in 
> the next version for kernels built without it.

Support for loading the CA keys stored in the MOK db onto the mok
keyring, only if the secondary keyring is configured would really
simplify the code.   Support for using the mok  keyring without the
secondary keyring being configured, could always be added later.  As
long as the other distros agree, I'm all for it.

thanks,

Mimi

