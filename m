Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E31764E20B
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Dec 2022 20:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiLOT7Q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Dec 2022 14:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiLOT7O (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Dec 2022 14:59:14 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D5B537D4;
        Thu, 15 Dec 2022 11:59:12 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFJme90011349;
        Thu, 15 Dec 2022 19:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=EdESrXaU0ECbNnOkHVR0YT/iFgICApvZ54u5zXnNNlQ=;
 b=se1yqwcnl9T2XsrUIb2lAlKVRxqaroH59mzcLOBiBXUW6i6f7QspK8iMubPbMYP4P6XK
 HtxmzW0IdKc1pDCtDyjPoVqY2r72yQ4fS1Z++2E1At3qMsrNifSgWMq/CvUiyqtBQ87n
 Ynaqk0W/tqN1ccObDDNgHz2jrCa8mNIDpQxyhq7Wzba7mma9fvUvA54Nou/8qzhM4iKg
 lMNkDpzmf4D3AOA7Vv17orvxJ2aeFyiepUrrwH6SNNnz3a2jRxe+Qihr0gKbR4kNXRIy
 3Bl7TQr1XI0q/P0tq07UIv5bd0RLvkQFXY114WUxm5k6v2OeXRoS0My0kLob4vc0fh1d YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mga2n864d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 19:58:42 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BFJnYRR013263;
        Thu, 15 Dec 2022 19:58:41 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mga2n863s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 19:58:41 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFJvxMt006102;
        Thu, 15 Dec 2022 19:58:40 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3meyfe0s06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 19:58:40 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BFJwc5G25952780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 19:58:38 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A75F58056;
        Thu, 15 Dec 2022 19:58:38 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC0225803F;
        Thu, 15 Dec 2022 19:58:36 +0000 (GMT)
Received: from sig-9-65-242-118.ibm.com (unknown [9.65.242.118])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 15 Dec 2022 19:58:36 +0000 (GMT)
Message-ID: <1c51910a35a1d113256494827fd66ccc7473632e.camel@linux.ibm.com>
Subject: Re: [PATCH v3 00/10] Add CA enforcement keyring restrictions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "pvorel@suse.cz" <pvorel@suse.cz>,
        "noodles@fb.com" <noodles@fb.com>, "tiwai@suse.de" <tiwai@suse.de>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Elaine Palmer <erpalmer@linux.vnet.ibm.com>,
        Coiby Xu <coxu@redhat.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Date:   Thu, 15 Dec 2022 14:58:36 -0500
In-Reply-To: <4CE6F17D-9D87-4024-9E1A-FDFE7C29D5FC@oracle.com>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
         <b8e54d077da633132eb6da03ea536face095a425.camel@linux.ibm.com>
         <4CE6F17D-9D87-4024-9E1A-FDFE7C29D5FC@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KyyGrrQum1ld-4P0H3neHLwIl3229K-2
X-Proofpoint-GUID: hxqPeCPseFoOqWAP9f0vmVRYTffNbSol
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_11,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212150164
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-12-15 at 16:26 +0000, Eric Snowberg wrote:
> 
> > On Dec 15, 2022, at 3:21 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Tue, 2022-12-13 at 19:33 -0500, Eric Snowberg wrote:
> >> Prior to the introduction of the machine keyring, most distros simply 
> >> allowed all keys contained within the platform keyring to be used
> >> for both kernel and module verification.  This was done by an out of
> >> tree patch.  Some distros took it even further and loaded all these keys
> >> into the secondary trusted keyring.  This also allowed the system owner 
> >> to add their own key for IMA usage.
> >> 
> >> Each distro contains similar documentation on how to sign kernel modules
> >> and enroll the key into the MOK.  The process is fairly straightforward.
> >> With the introduction of the machine keyring, the process remains
> >> basically the same, without the need for any out of tree patches.
> >> 
> >> The machine keyring allowed distros to eliminate the out of tree patches
> >> for kernel module signing.  However, it falls short in allowing the end 
> >> user to add their own keys for IMA. Currently the machine keyring can not 
> >> be used as another trust anchor for adding keys to the ima keyring, since 
> >> CA enforcement does not currently exist.  This would expand the current 
> >> integrity gap. The IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY 
> >> Kconfig states that keys may be added to the ima keyrings if the key is 
> >> validly signed by a CA cert in the system built-in or secondary trusted 
> >> keyring.  Currently there is not code that enforces the contents of a
> >> CA cert. Any key in the builtin or secondary keyring can be used. 
> >> 
> >> To allow IMA to be enabled with the machine keyring, this series introduces
> >> enforcement of key usage in the certificate. This series also applies
> >> this enforcement across all kernel keyrings.
> >> 
> >> The machine keyring shares  similarities with both the builtin and
> >> secondary keyrings.  Similar to the builtin, no keys may be added to the
> >> machine keyring following boot. The secondary keyring allows user
> >> provided keys to be added following boot; however, a previously enrolled
> >> kernel key must vouch for the key before it may be included. The system
> >> owner may include their own keys into the machine keyring prior to boot.
> >> If the end-user is not the system owner, they may not add their own keys
> >> to the machine keyring.  
> >> 
> >> The machine keyring is only populated when Secure Boot is enabled.  A
> >> system owner has the ability to control the entire Secure Boot keychain
> >> (PK, KEK, DB, and DBX).  The system owner can also turn Secure Boot off.
> >> With this control, they may use insert-sys-cert to include their own key 
> >> and re-sign their kernel and have it boot.  The system owner also has 
> >> control to include or exclude MOK keys. This series does not try to 
> >> interpret how a system owner has configured their machine.  If the system 
> >> owner has taken the steps to add their own MOK keys, they will be 
> >> included in the machine keyring and used for verification, exactly 
> >> the same way as keys contained in the builtin and secondary keyrings.
> >> Since the system owner has the ability to add keys before booting to
> >> either the machine or builtin keyrings, it is viewed as inconsequential 
> >> if the key originated from one or the other.
> >> 
> >> This series introduces two different ways to configure the machine keyring.
> >> By default, nothing changes and all MOK keys are loaded into it.  Whenever
> >> a CA cert is found within the machine, builtin, or secondary, a flag 
> >> indicating this is stored in the public key struct.  The other option is 
> >> if the new Kconfig INTEGRITY_CA_MACHINE_KEYRING is enabled, only CA certs 
> >> will be loaded into the machine keyring. All remaining MOK keys will be 
> >> loaded into the platform keyring.
> >> 
> >> A CA cert shall be defined as any X509 certificate that contains the 
> >> keyCertSign key usage and has the CA bit set to true.
> > 
> > Hi Eric,
> > 
> > Allowing CA certificates with the digitalSignature key usage flag
> > enabled defeats the purpose of the new Kconfig.  Please update the
> > above definition to exclude the digitalSignature key usage flag and
> > modify the code accordingly.
> 
> Within v2, the request was made to allow Intermediate CA certificates to be 
> loaded directly.  The Intermediate CA referenced was the one used by kernel.org.  
> This Intermediate CA contains both digitalSignature and keyCertSign.  If the code 
> is changed to exclude this certificate, now the root CA has to be loaded again.  Is that 
> the intent?

That definitely was not the intent.  Nor would it address the issue of
a particular intermediate CA certificate having both keyCertSign and
digitalSignature.

thanks,

Mimi

