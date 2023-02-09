Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A83B68FD7D
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Feb 2023 03:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjBIC7K (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Feb 2023 21:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjBIC6N (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Feb 2023 21:58:13 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA5610D9;
        Wed,  8 Feb 2023 18:54:57 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3192q8Su028492;
        Thu, 9 Feb 2023 02:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=xRBCpmMlb+PdxAxbWJgFjwkY9Jhnv3MJ4cp7Q/6EzsY=;
 b=saqJ+7WSaSVGTecgo/8Q4Kn2NksUR7c28xV1hoGJxk0uSMrS0Kd5x6GiMOl1Wh+oTJNg
 NkOC5MCRdfKvt5DhK5ZmqIH8R+ab2S1dzp84u0dEMleSDDxSRoYboqT1pag/eIKva7QJ
 15aQhxJJTMCXolTDhx5O7SA/NaRHKW0fZ4+DhjWfo6HXpXzE/Y6rwHGpaljlmKJfX8ru
 EMtgRCaQRO0rbRYdjRfMuO/iPkiYOJ9T/LhpNTjHnH9nlIiu07nM+hYEwJHBZZBefIUP
 ptSaXFRY7mrsUbgEZwuESTODgy+5H7SpP2kN9LfIcUrgbzcEM3sWY1KN54Yn9mEzLDpA Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmre4g1q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 02:54:35 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3192qM8R029126;
        Thu, 9 Feb 2023 02:54:34 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmre4g1pu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 02:54:34 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31905bgV003472;
        Thu, 9 Feb 2023 02:54:33 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3nhf07gcch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 02:54:33 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3192sWqL54264188
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Feb 2023 02:54:32 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3549358064;
        Thu,  9 Feb 2023 02:54:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA1F15805C;
        Thu,  9 Feb 2023 02:54:29 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.12.101])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  9 Feb 2023 02:54:29 +0000 (GMT)
Message-ID: <d30b895e677613bca520d626741cc9424f8d46e8.camel@linux.ibm.com>
Subject: Re: [PATCH v4 0/6] Add CA enforcement keyring restrictions
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
        "tadeusz.struk@intel.com" <tadeusz.struk@intel.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Elaine Palmer <erpalmer@linux.vnet.ibm.com>,
        Coiby Xu <coxu@redhat.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>
Date:   Wed, 08 Feb 2023 21:54:29 -0500
In-Reply-To: <D598759A-48FD-46E2-979C-3022A5920C0F@oracle.com>
References: <20230207025958.974056-1-eric.snowberg@oracle.com>
         <41dffdaeb7eb7840f7e38bc691fbda836635c9f9.camel@linux.ibm.com>
         <D598759A-48FD-46E2-979C-3022A5920C0F@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1GQvbMw_VvDMw8nv8e1DUbPR4TuWc0Ba
X-Proofpoint-ORIG-GUID: JKwvLUPNM1mWkzMrS0fiyiX_lTaE9-OX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_11,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302090022
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-02-08 at 23:26 +0000, Eric Snowberg wrote:
> 
> > On Feb 8, 2023, at 5:38 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > [CC'ing: Lee, Chun-Yi]
> > 
> > On Mon, 2023-02-06 at 21:59 -0500, Eric Snowberg wrote:
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
> >> user to add their own keys for IMA. Currently, the machine keyring can not 
> >> be used as another trust anchor for adding keys to the ima keyring, since 
> >> CA enforcement does not currently exist.  This would expand the current 
> >> integrity gap. The IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY 
> >> Kconfig states that keys may be added to the ima keyrings if the key is 
> >> validly signed by a CA cert in the system built-in or secondary trusted 
> >> keyring.  Currently, there is not code that enforces the contents of a
> >> CA cert.
> >> 
> >> This series introduces a way to do CA enforement with the machine
> >> keyring. It introduces three different ways to configure the machine
> >> keyring. A new menu option is added to control the type of keys that may
> >> be added to it.  The options include none, min, and max restrictions. The
> >> default is CONFIG_INTEGRITY_CA_MACHINE_KEYRING_NONE. This allows all MOK
> >> keys into the machine keyring.  When CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MIN
> >> is selected, the X.509 CA bit must be true.  Also, the key usage must
> >> contain keyCertSign, any other usage field may also be set. When 
> >> CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MAX is selected, the X.509 CA bit
> >> must be true.  Also, the key usage must contain keyCertSign and the
> >> digitialSignature usage may not be set. If a key doesn't pass the CA
> >> restriction check, instead of going into the machine keyring, it is
> >> added to the platform keyring. With the ability to configure the machine
> >> keyring with CA restrictions, code that prevented the machine keyring
> >> from being enabled with IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
> >> has been removed.
> >> 
> >> Changelog:
> >> v4:
> >> - Removed all code that validated the certificate chain back to the root
> >>  CA. Now the only restriction is what is initially placed in the
> >>  machine keyring.
> >> - Check and store if the X.509 usage contains digitalSignature
> >> - New Kconfig menu item with none, min and max CA restriction on the 
> >>  machine keyring
> > 
> > Thank you, Eric.
> > 
> > For complete separation of certificate usage, at least in the "max" CA
> > restriction case, the next step would be to limit certificates being
> > loaded onto the IMA keyring to those with key usage of
> > "digitalSignature".
> > 
> > Perhaps also require a "codeSigning" extendedKeyUsage, though that
> > might break existing usages.  The "codeSigning" checking could
> > piggyback on Joey's proposed "Check codeSigning extended key usage
> > extension" patch set.
> > 
> > What do you think?  Do you have any concerns with limiting the type of
> > certificate being loaded onto the IMA keyring to those with
> > "digitalSignature"?
> 
> In the MAX setting I would not have a concern.  Instead of restrict_link_to_ima 
> being a macro, a new restriction similar to restrict_link_by_ca could be created.  
> The new restriction would simply verify digitialSignature is set and the key can be 
> vouched for by either the built-in or secondary keyrings. Joey’s work to parse 
> the extended key usage extension could also be included in this restriction.

Sounds good.

> I’m assuming this would be follow on work?

Yes, that probably makes the most sense.

-- 
thanks,

Mimi

