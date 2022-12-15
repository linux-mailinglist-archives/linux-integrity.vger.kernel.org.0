Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6DF64D96D
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Dec 2022 11:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiLOKVp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Dec 2022 05:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLOKVm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Dec 2022 05:21:42 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31CF1D66E;
        Thu, 15 Dec 2022 02:21:40 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BF9uC8T001035;
        Thu, 15 Dec 2022 10:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=S4ov8wjBogUxgDiUwuK2TyllUrK3+9hOgjWqsOnBMAI=;
 b=FC4sWS0+CrFUHn0W1lGlm+bt93oucbe5k7S3pAlfh2DD53k7vwk9mEsSDUC7Gp52dp/7
 uJh3HLRe54cOmuSTKnblaaXvETIiXBbm8Lq07zYw+9EtlMzYRlbPURkOLng1iF3sa1Mq
 u/CNjISgZvXvbKssG1G9H5qi/nRiZ5cbWsCX3Sr9WG5cKF8qxzk8sGRjVM4uNSSjceGm
 eX075FXEtcKhMwHtuJCB4+nPStbEBVb0iO91AZgJKTeeXHboFkgbs6md1w9uyoi4HR3Z
 mDs/kidO04cokypl45mOwT8a4YqoD0tgtf/wotysr+wV9iRxOR/jb9kgxRqM9wIe4St4 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mg1cwgm1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 10:21:06 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BFABaiq010137;
        Thu, 15 Dec 2022 10:21:05 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mg1cwgm0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 10:21:05 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BF8lZxI017100;
        Thu, 15 Dec 2022 10:21:04 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3mf07gmu1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 10:21:04 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BFAL3x02425344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 10:21:03 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 087F558067;
        Thu, 15 Dec 2022 10:21:03 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7E7B58059;
        Thu, 15 Dec 2022 10:21:00 +0000 (GMT)
Received: from sig-9-65-242-118.ibm.com (unknown [9.65.242.118])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 15 Dec 2022 10:21:00 +0000 (GMT)
Message-ID: <b8e54d077da633132eb6da03ea536face095a425.camel@linux.ibm.com>
Subject: Re: [PATCH v3 00/10] Add CA enforcement keyring restrictions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, jarkko@kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, noodles@fb.com, tiwai@suse.de,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        erpalmer@linux.vnet.ibm.com, coxu@redhat.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Thu, 15 Dec 2022 05:21:00 -0500
In-Reply-To: <20221214003401.4086781-1-eric.snowberg@oracle.com>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n4ALZT2PNIzjH8thjAdCOkbVjk8Ai0TN
X-Proofpoint-ORIG-GUID: 93w-pfjNkzgC1KjSJ_x7GKB-12JNiM_V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_03,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212150080
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-12-13 at 19:33 -0500, Eric Snowberg wrote:
> Prior to the introduction of the machine keyring, most distros simply 
> allowed all keys contained within the platform keyring to be used
> for both kernel and module verification.  This was done by an out of
> tree patch.  Some distros took it even further and loaded all these keys
> into the secondary trusted keyring.  This also allowed the system owner 
> to add their own key for IMA usage.
> 
> Each distro contains similar documentation on how to sign kernel modules
> and enroll the key into the MOK.  The process is fairly straightforward.
> With the introduction of the machine keyring, the process remains
> basically the same, without the need for any out of tree patches.
> 
> The machine keyring allowed distros to eliminate the out of tree patches
> for kernel module signing.  However, it falls short in allowing the end 
> user to add their own keys for IMA. Currently the machine keyring can not 
> be used as another trust anchor for adding keys to the ima keyring, since 
> CA enforcement does not currently exist.  This would expand the current 
> integrity gap. The IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY 
> Kconfig states that keys may be added to the ima keyrings if the key is 
> validly signed by a CA cert in the system built-in or secondary trusted 
> keyring.  Currently there is not code that enforces the contents of a
> CA cert. Any key in the builtin or secondary keyring can be used. 
> 
> To allow IMA to be enabled with the machine keyring, this series introduces
> enforcement of key usage in the certificate. This series also applies
> this enforcement across all kernel keyrings.
> 
> The machine keyring shares  similarities with both the builtin and
> secondary keyrings.  Similar to the builtin, no keys may be added to the
> machine keyring following boot. The secondary keyring allows user
> provided keys to be added following boot; however, a previously enrolled
> kernel key must vouch for the key before it may be included. The system
> owner may include their own keys into the machine keyring prior to boot.
> If the end-user is not the system owner, they may not add their own keys
> to the machine keyring.  
> 
> The machine keyring is only populated when Secure Boot is enabled.  A
> system owner has the ability to control the entire Secure Boot keychain
> (PK, KEK, DB, and DBX).  The system owner can also turn Secure Boot off.
> With this control, they may use insert-sys-cert to include their own key 
> and re-sign their kernel and have it boot.  The system owner also has 
> control to include or exclude MOK keys. This series does not try to 
> interpret how a system owner has configured their machine.  If the system 
> owner has taken the steps to add their own MOK keys, they will be 
> included in the machine keyring and used for verification, exactly 
> the same way as keys contained in the builtin and secondary keyrings.
> Since the system owner has the ability to add keys before booting to
> either the machine or builtin keyrings, it is viewed as inconsequential 
> if the key originated from one or the other.
> 
> This series introduces two different ways to configure the machine keyring.
> By default, nothing changes and all MOK keys are loaded into it.  Whenever
> a CA cert is found within the machine, builtin, or secondary, a flag 
> indicating this is stored in the public key struct.  The other option is 
> if the new Kconfig INTEGRITY_CA_MACHINE_KEYRING is enabled, only CA certs 
> will be loaded into the machine keyring. All remaining MOK keys will be 
> loaded into the platform keyring.
> 
> A CA cert shall be defined as any X509 certificate that contains the 
> keyCertSign key usage and has the CA bit set to true.

Hi Eric,

Allowing CA certificates with the digitalSignature key usage flag
enabled defeats the purpose of the new Kconfig.  Please update the
above definition to exclude the digitalSignature key usage flag and
modify the code accordingly.

thanks,

Mimi

> With this series applied, CA enforcement is in place whenever 
> IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is enabled.  Meaning, 
> before any key can be included into the ima keyring, it must be
> vouched for by a CA key contained within the builtin, secondary, or 
> machine keyrings.
> 
> IMA allows userspace applications to be signed. The enduser may sign
> their own application, however they may also want to use an application
> provided by a 3rd party.  The entity building the kernel, may not be the
> same entity building the userspace program.  The system owner may also
> be a third entity.  If the system owner trusts the entity building the
> userspace program, they will include their public key within the MOK.
> This key would be used to sign the key added to the ima keyring. Not all
> 3rd party userspace providers have the capability to properly manage a
> root CA.  Some may outsource to a different code signing provider.  Many
> code signing providers use Intermediate CA certificates. Therefore, this
> series also includes support for Intermediate CA certificates.
> 
> This series could be broken up into 3 different parts.  The first two
> patches could be taken now.  They solve current issues that will be
> triggered by the build robots.  Patches 3-8 add CA enforcement for the
> ima keyring.  Patches 9-10 restrict the machine keyring to only load CA
> certs into it.  Patches 9-10 require all the previous patches. 
> 
> Changelog:
> 
> v3:
> - Allow Intermediate CA certs to be enrolled through the MOK. The
>   Intermediate CA cert must contain keyCertSign key usage and have the 
>   CA bit set to true. This was done by removing the self signed
>   requirement.
> 
> 
> Eric Snowberg (10):
>   KEYS: Create static version of public_key_verify_signature
>   KEYS: Add missing function documentation
>   KEYS: X.509: Parse Basic Constraints for CA
>   KEYS: X.509: Parse Key Usage
>   KEYS: Introduce a CA endorsed flag
>   KEYS: Introduce keyring restriction that validates ca trust
>   KEYS: X.509: Flag Intermediate CA certs as endorsed
>   integrity: Use root of trust signature restriction
>   KEYS: CA link restriction
>   integrity: restrict INTEGRITY_KEYRING_MACHINE to restrict_link_by_ca
> 
>  certs/system_keyring.c                    | 32 +++++++++-
>  crypto/asymmetric_keys/restrict.c         | 76 +++++++++++++++++++++++
>  crypto/asymmetric_keys/x509_cert_parser.c | 31 +++++++++
>  crypto/asymmetric_keys/x509_parser.h      |  2 +
>  crypto/asymmetric_keys/x509_public_key.c  | 16 +++++
>  include/crypto/public_key.h               | 30 +++++++++
>  include/keys/system_keyring.h             | 12 +++-
>  include/linux/ima.h                       | 11 ++++
>  include/linux/key-type.h                  |  3 +
>  include/linux/key.h                       |  2 +
>  security/integrity/Kconfig                | 11 +++-
>  security/integrity/digsig.c               | 12 ++--
>  security/integrity/ima/Kconfig            |  6 +-
>  security/keys/key.c                       | 13 ++++
>  14 files changed, 245 insertions(+), 12 deletions(-)
> 
> 
> base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476


