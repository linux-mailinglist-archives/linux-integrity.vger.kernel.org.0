Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C497264E2B9
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Dec 2022 22:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLOVD4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Dec 2022 16:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiLOVDz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Dec 2022 16:03:55 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49792537F8;
        Thu, 15 Dec 2022 13:03:54 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFKDbvf020300;
        Thu, 15 Dec 2022 21:03:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=5EIf5iQVnmgUls2ZDnpbHyXKrknorwiyc3o2YZxPpgA=;
 b=pIugTmlfdFlUnf97GtIRyjHy/wL/ajpdbSyF3xQeOt4VQrZJv3G+VNuv8nZJRX65dvEi
 GDEO847+/eOQM4EAiXO9s/wapkEcFnWeLsMUqvfQMaK7LoAh/V9zo2wBCtMfT9TE+JFi
 ATs0az7jyp4eNv+PYvV/kBAgPv2cwlst9Nu4c4mOPQGo6DXFKWEYC2TSlTnSHPJiQ9XC
 IQecRE/F+kDOjcoB2HkMajhxwR+0Gmdr8R5/OEuMg2M3Otu5Rg9/EjwzThPAmNd9tiNU
 i2CIFDSg7hclj79Ju26CfZ/OfZ/mYERpe0z4fvepk944X3CMJKIqNTNwo49UKwJ1jvH2 Ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mgae4h246-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 21:03:31 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BFKX5XR026718;
        Thu, 15 Dec 2022 21:03:30 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mgae4h23s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 21:03:30 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFKEC6r011603;
        Thu, 15 Dec 2022 21:03:29 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3meyyj10up-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 21:03:29 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BFL3R9A6750778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 21:03:27 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77B9858064;
        Thu, 15 Dec 2022 21:03:27 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A247F5803F;
        Thu, 15 Dec 2022 21:03:25 +0000 (GMT)
Received: from sig-9-65-242-118.ibm.com (unknown [9.65.242.118])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 15 Dec 2022 21:03:25 +0000 (GMT)
Message-ID: <7df94da37c100c160436892a6996ba30e3fd6dc8.camel@linux.ibm.com>
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
Date:   Thu, 15 Dec 2022 16:03:25 -0500
In-Reply-To: <17855993-519C-4DAC-B62F-9DB473CF249B@oracle.com>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
         <b8e54d077da633132eb6da03ea536face095a425.camel@linux.ibm.com>
         <4CE6F17D-9D87-4024-9E1A-FDFE7C29D5FC@oracle.com>
         <1c51910a35a1d113256494827fd66ccc7473632e.camel@linux.ibm.com>
         <17855993-519C-4DAC-B62F-9DB473CF249B@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jmVqMKgocSyuiiU72wqrDIyXL6TWh_va
X-Proofpoint-GUID: FAetqsBPcV6TuUt0BpC4ytincneqh9Am
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_11,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 mlxlogscore=873 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212150176
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-12-15 at 20:28 +0000, Eric Snowberg wrote:
> 
> > On Dec 15, 2022, at 12:58 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Thu, 2022-12-15 at 16:26 +0000, Eric Snowberg wrote:
> >> 
> >>> On Dec 15, 2022, at 3:21 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >>> 
> >>> On Tue, 2022-12-13 at 19:33 -0500, Eric Snowberg wrote:
> >>>> Prior to the introduction of the machine keyring, most distros simply 
> >>>> allowed all keys contained within the platform keyring to be used
> >>>> for both kernel and module verification.  This was done by an out of
> >>>> tree patch.  Some distros took it even further and loaded all these keys
> >>>> into the secondary trusted keyring.  This also allowed the system owner 
> >>>> to add their own key for IMA usage.
> >>>> 
> >>>> Each distro contains similar documentation on how to sign kernel modules
> >>>> and enroll the key into the MOK.  The process is fairly straightforward.
> >>>> With the introduction of the machine keyring, the process remains
> >>>> basically the same, without the need for any out of tree patches.
> >>>> 
> >>>> The machine keyring allowed distros to eliminate the out of tree patches
> >>>> for kernel module signing.  However, it falls short in allowing the end 
> >>>> user to add their own keys for IMA. Currently the machine keyring can not 
> >>>> be used as another trust anchor for adding keys to the ima keyring, since 
> >>>> CA enforcement does not currently exist.  This would expand the current 
> >>>> integrity gap. The IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY 
> >>>> Kconfig states that keys may be added to the ima keyrings if the key is 
> >>>> validly signed by a CA cert in the system built-in or secondary trusted 
> >>>> keyring.  Currently there is not code that enforces the contents of a
> >>>> CA cert. Any key in the builtin or secondary keyring can be used. 
> >>>> 
> >>>> To allow IMA to be enabled with the machine keyring, this series introduces
> >>>> enforcement of key usage in the certificate. This series also applies
> >>>> this enforcement across all kernel keyrings.
> >>>> 
> >>>> The machine keyring shares  similarities with both the builtin and
> >>>> secondary keyrings.  Similar to the builtin, no keys may be added to the
> >>>> machine keyring following boot. The secondary keyring allows user
> >>>> provided keys to be added following boot; however, a previously enrolled
> >>>> kernel key must vouch for the key before it may be included. The system
> >>>> owner may include their own keys into the machine keyring prior to boot.
> >>>> If the end-user is not the system owner, they may not add their own keys
> >>>> to the machine keyring.  
> >>>> 
> >>>> The machine keyring is only populated when Secure Boot is enabled.  A
> >>>> system owner has the ability to control the entire Secure Boot keychain
> >>>> (PK, KEK, DB, and DBX).  The system owner can also turn Secure Boot off.
> >>>> With this control, they may use insert-sys-cert to include their own key 
> >>>> and re-sign their kernel and have it boot.  The system owner also has 
> >>>> control to include or exclude MOK keys. This series does not try to 
> >>>> interpret how a system owner has configured their machine.  If the system 
> >>>> owner has taken the steps to add their own MOK keys, they will be 
> >>>> included in the machine keyring and used for verification, exactly 
> >>>> the same way as keys contained in the builtin and secondary keyrings.
> >>>> Since the system owner has the ability to add keys before booting to
> >>>> either the machine or builtin keyrings, it is viewed as inconsequential 
> >>>> if the key originated from one or the other.
> >>>> 
> >>>> This series introduces two different ways to configure the machine keyring.
> >>>> By default, nothing changes and all MOK keys are loaded into it.  Whenever
> >>>> a CA cert is found within the machine, builtin, or secondary, a flag 
> >>>> indicating this is stored in the public key struct.  The other option is 
> >>>> if the new Kconfig INTEGRITY_CA_MACHINE_KEYRING is enabled, only CA certs 
> >>>> will be loaded into the machine keyring. All remaining MOK keys will be 
> >>>> loaded into the platform keyring.
> >>>> 
> >>>> A CA cert shall be defined as any X509 certificate that contains the 
> >>>> keyCertSign key usage and has the CA bit set to true.
> >>> 
> >>> Hi Eric,
> >>> 
> >>> Allowing CA certificates with the digitalSignature key usage flag
> >>> enabled defeats the purpose of the new Kconfig.  Please update the
> >>> above definition to exclude the digitalSignature key usage flag and
> >>> modify the code accordingly.
> >> 
> >> Within v2, the request was made to allow Intermediate CA certificates to be 
> >> loaded directly.  The Intermediate CA referenced was the one used by kernel.org.  
> >> This Intermediate CA contains both digitalSignature and keyCertSign.  If the code 
> >> is changed to exclude this certificate, now the root CA has to be loaded again.  Is that 
> >> the intent?
> > 
> > That definitely was not the intent.  Nor would it address the issue of
> > a particular intermediate CA certificate having both keyCertSign and
> > digitalSignature.
> 
> Sorry, I’m not following.  Why is it an issue that an intermediate CA certificate contains 
> both keyCertSign and digitalSignature? Why would we want to exclude an Intermediate
> CA cert like the one used on kernel.org?

I must be missing something.  Isn't the purpose of "keyUsage" to
minimize how a certificate may be used?   Why would we want the same
certificate to be used for both certificate signing and code signing?

thanks,

Mimi

