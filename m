Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535EB6521C9
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Dec 2022 14:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiLTNy1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Dec 2022 08:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiLTNy0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Dec 2022 08:54:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868661ADBC
        for <linux-integrity@vger.kernel.org>; Tue, 20 Dec 2022 05:54:25 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BKDheg6007394;
        Tue, 20 Dec 2022 13:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=k0mH1g0caZuaXpkCcHz4v1RgA/IziEcMh2kuNEY7sZA=;
 b=NmkjGFSj8trOuo80Zj52toq5k85CMGvd+mv0PtMHXkXvKSmm5ErC5hz71eTDTlBfBaMS
 Uq/pWlc638US+wfeRL6SWhRxS5BVNiJXWQjSBU4+JPQwg3+HmZtYFHZYOHfpzFkZeTn0
 SVIHHLikN/ib7rntVNrQ3lIqT7sAqO1l1qHcfPS9ORv54tyFdds19lapM1H1bXUgSJLL
 LpbXukqtkYB8BVWiXyXlCZiXZmalgQO+VvHDeLRmJhfAadWB3z2Ju4J8v52qdHeG7Afv
 BOFWV3pp+/mGtnOtcdXqDpn54ZGNrhBuUzyJpXUsODDNNsiZoKbF3UETE4gN4H7JUGk6 3Q== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mke6d88sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 13:54:22 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BKCLbvi007487;
        Tue, 20 Dec 2022 13:54:21 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3mh6yxmn90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 13:54:21 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BKDsKfu46334404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Dec 2022 13:54:20 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B2145805C;
        Tue, 20 Dec 2022 13:54:20 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10BA65805E;
        Tue, 20 Dec 2022 13:54:20 +0000 (GMT)
Received: from sig-9-77-154-80.ibm.com (unknown [9.77.154.80])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 20 Dec 2022 13:54:19 +0000 (GMT)
Message-ID: <5e1c8d3bd5742979e328a267522347ad39b483a3.camel@linux.ibm.com>
Subject: Re: Question on loading trusted key with keyctl command
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Sughosh Ganu <sughosh.ganu@linaro.org>
Cc:     linux-integrity@vger.kernel.org
Date:   Tue, 20 Dec 2022 08:54:07 -0500
In-Reply-To: <e26b33be6ae53d4b566cffda092bcd45a3691c06.camel@HansenPartnership.com>
References: <CADg8p96Obiio+CUOCKzKqqc6m+B+zSDgs6SWLKSpSo5po94ApQ@mail.gmail.com>
         <ddefa55ad5c5f0dc0248a4017ea31e8e5d7a5328.camel@HansenPartnership.com>
         <CADg8p972AxWMTQbAXc=+zX9STtLdRKUmopbjEbq0rfFP_TKwrg@mail.gmail.com>
         <e26b33be6ae53d4b566cffda092bcd45a3691c06.camel@HansenPartnership.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eBKj2a840Ckse3gAXrhxDVgqpoGG7DZJ
X-Proofpoint-GUID: eBKj2a840Ckse3gAXrhxDVgqpoGG7DZJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-20_05,2022-12-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 clxscore=1011 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212200111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-12-20 at 07:50 -0500, James Bottomley wrote:
> On Tue, 2022-12-20 at 12:03 +0530, Sughosh Ganu wrote:
> > On Mon, 19 Dec 2022 at 18:20, James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > > 
> > > On Mon, 2022-12-19 at 15:50 +0530, Sughosh Ganu wrote:
> > > > hi,
> > > > I am trying to enable the evm hmac solution on my qemu arm64 virt
> > > > platform running Debian. I am using the swtpm 2.0 implementation
> > > > for
> > > > the TPM trusted source. Before I get into trying out the evm hmac
> > > > solution on the target system, I wanted to check creating the
> > > > trusted
> > > > and encrypted keys.  Other details on my set up are as follows
> > > > 
> > > > Distro - Debian 11
> > > > TPM - swtpm
> > > > Linux kernel - Linux version 6.1.0-13032, commit 77856d911a8c [1]
> > > > keyctl --version
> > > > keyctl from keyutils-1.6.1 (Built 2020-02-10)
> > > > 
> > > > When trying to follow the steps highlighted in the
> > > > Documentation/security/keys/trusted-encrypted.rst, I can generate
> > > > the
> > > > trusted key. However, when I try to load the trusted key using
> > > > the
> > > > command shown in the document, it throws an error. Has there been
> > > > a
> > > > change in the code, or am I missing some step when trying to load
> > > > the
> > > > trusted key?
> > > > 
> > > > Steps that I am following (after having created the SRK).
> > > > 
> > > > # keyctl add trusted kmk "new 32 keyhandle=0x81000001" @u
> > > > # keyctl show
> > > > Session Keyring
> > > >  442944693 --alswrv      0     0  keyring: _ses
> > > >  925986946 --alswrv      0 65534   \_ keyring: _uid.0
> > > >  401286062 --alswrv      0     0       \_ trusted: kmk
> > > > # keyctl pipe 401286062 > kmk.blob
> > > > # keyctl add trusted kmk "load `cat kmk.blob`
> > > > keyhandle=0x81000001"
> > > > @u
> > > > add_key: Invalid argument
> > > 
> > > kmk is your invalid argument ... you already have a key there. 
> > > Either
> > > unlink %trusted:kmk or add the new key at kmk1.
> > 
> > I was able to load the key after clearing the keyring. Thanks James
> > and Mimi for your pointers.
> 
> Actually, I think this is a bug in trusted keys.  Add on existing key
> is supposed to go through the update path.  If the path doesn't exist
> it returns -EEXIST.  Trusted keys have an update path but they return -
> EINVAL if the trusted key command is anything but update (which is used
> to reseal a key).  Obviously this is incorrect and the code should be
> returning -EEXIST for a key we refuse to update to match every other
> key type.

Re-loading an existing key was previously permitted.  Obviously this
changed at some point.   Any "fixes" should point out when it changed.

-- 
thanks,

Mimi

