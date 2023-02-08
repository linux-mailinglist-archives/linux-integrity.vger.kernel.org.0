Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B1268EF23
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Feb 2023 13:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjBHMjl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Feb 2023 07:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBHMjk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Feb 2023 07:39:40 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAB63A879;
        Wed,  8 Feb 2023 04:39:38 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318CXYvC007368;
        Wed, 8 Feb 2023 12:38:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=IRzwm9AVGgskVp8h3mjPNd2/4+TK1U8rD6DSXrUD8DM=;
 b=EfrAWiezbwrEuDSNLKkJAJJInfdyoKMNQ42ncgDZV3CTUzFm1WpQDCNKgqwLkAflhY8W
 3j/UcR8IYtq2sj/aJJVqAVEFGs/ClyucM/0GaMphi0B/AJ/aDTNn3E4h32WeX0SY83Ed
 1ntyjyvAgKm8GK7MfRLLFoFt+8mpRG2IGH3dP0ifh5o2SY8+kzD9jEhoF6gvW9nmzb+k
 R40XhJPeCOO8hUHE6p38ajmj61xFE6m0FDxDE52TQJaN+VLcsms38hD8JlRIaN4Q/T/P
 re4OlVAVc1PEu7YbKKmvov0CaNJp8Q9MN5GnNcppbN/dAvlnskksvGEgVCV8XXFCk4PS zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmbukg5bc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 12:38:59 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 318CaID3017889;
        Wed, 8 Feb 2023 12:38:58 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmbukg5aq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 12:38:58 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 318BFQA4020070;
        Wed, 8 Feb 2023 12:38:57 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3nhf07dbnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 12:38:57 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 318CcuP339322000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Feb 2023 12:38:56 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A23F258056;
        Wed,  8 Feb 2023 12:38:56 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D78B85804E;
        Wed,  8 Feb 2023 12:38:54 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.35.178])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Feb 2023 12:38:54 +0000 (GMT)
Message-ID: <41dffdaeb7eb7840f7e38bc691fbda836635c9f9.camel@linux.ibm.com>
Subject: Re: [PATCH v4 0/6] Add CA enforcement keyring restrictions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, jarkko@kernel.org,
        dhowells@redhat.com, dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, tadeusz.struk@intel.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        erpalmer@linux.vnet.ibm.com, coxu@redhat.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>
Date:   Wed, 08 Feb 2023 07:38:54 -0500
In-Reply-To: <20230207025958.974056-1-eric.snowberg@oracle.com>
References: <20230207025958.974056-1-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fyZ3pT9D0GHxvR0UwdzOlRn_yDOSgX35
X-Proofpoint-GUID: wRw-yqSDbypCUtr1XIWbFxRUbQoSLijl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_04,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302080112
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[CC'ing: Lee, Chun-Yi]

On Mon, 2023-02-06 at 21:59 -0500, Eric Snowberg wrote:
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
> user to add their own keys for IMA. Currently, the machine keyring can not 
> be used as another trust anchor for adding keys to the ima keyring, since 
> CA enforcement does not currently exist.  This would expand the current 
> integrity gap. The IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY 
> Kconfig states that keys may be added to the ima keyrings if the key is 
> validly signed by a CA cert in the system built-in or secondary trusted 
> keyring.  Currently, there is not code that enforces the contents of a
> CA cert.
> 
> This series introduces a way to do CA enforement with the machine
> keyring. It introduces three different ways to configure the machine
> keyring. A new menu option is added to control the type of keys that may
> be added to it.  The options include none, min, and max restrictions. The
> default is CONFIG_INTEGRITY_CA_MACHINE_KEYRING_NONE. This allows all MOK
> keys into the machine keyring.  When CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MIN
> is selected, the X.509 CA bit must be true.  Also, the key usage must
> contain keyCertSign, any other usage field may also be set. When 
> CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MAX is selected, the X.509 CA bit
> must be true.  Also, the key usage must contain keyCertSign and the
> digitialSignature usage may not be set. If a key doesn't pass the CA
> restriction check, instead of going into the machine keyring, it is
> added to the platform keyring. With the ability to configure the machine
> keyring with CA restrictions, code that prevented the machine keyring
> from being enabled with IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
> has been removed.
> 
> Changelog:
> v4:
> - Removed all code that validated the certificate chain back to the root
>   CA. Now the only restriction is what is initially placed in the
>   machine keyring.
> - Check and store if the X.509 usage contains digitalSignature
> - New Kconfig menu item with none, min and max CA restriction on the 
>   machine keyring

Thank you, Eric.

For complete separation of certificate usage, at least in the "max" CA
restriction case, the next step would be to limit certificates being
loaded onto the IMA keyring to those with key usage of
"digitalSignature".

Perhaps also require a "codeSigning" extendedKeyUsage, though that
might break existing usages.  The "codeSigning" checking could
piggyback on Joey's proposed "Check codeSigning extended key usage
extension" patch set.

What do you think?  Do you have any concerns with limiting the type of
certificate being loaded onto the IMA keyring to those with
"digitalSignature"?

-- 
thanks,

Mimi

