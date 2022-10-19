Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4AD603745
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Oct 2022 02:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiJSAyG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Oct 2022 20:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJSAyF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Oct 2022 20:54:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6D0C787A;
        Tue, 18 Oct 2022 17:54:04 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29J0g8SH014256;
        Wed, 19 Oct 2022 00:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=M4YM3Zp3y6UhKaOdP0cTdGdvvzaOvoeI6HEani4nNic=;
 b=IypdOPluw+swsF5XQTVf6T7ppii4m+bM2FxQrAL0/5C3dA0SJ11+ZQWvGV04RhFCiiqu
 MfK/ONh/5NL7bHpT9dyUXAcxibwEw8jebwohOtLPs7JSjN3vASLo/ATA05iuAFYfEsYB
 AiaxhXRTgaKIh6nZ6VCMMs2n8LbiiXQlBeVmF7+NGRSD12Y//WFZnnX5J2V8q0VwsBDP
 7rBWP1TbHrG/rEgcwI0fAAWtvufEmolVJS41ujReN/BWNr4Ba0wXkD2Hpow542FqknSO
 uK6h9N7z0p6gxlnPs3iWCOrS6GJILbUlGMOET6W5uNgDmBW/gSEOxThvjtduZmbCWHnr Qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ka6x5r80s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 00:53:43 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29J0gwbM017117;
        Wed, 19 Oct 2022 00:53:43 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ka6x5r806-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 00:53:42 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29J0bwgZ005153;
        Wed, 19 Oct 2022 00:53:41 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03wdc.us.ibm.com with ESMTP id 3k7mg9j2w9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 00:53:41 +0000
Received: from smtpav04.wdc07v.mail.ibm.com ([9.208.128.116])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29J0rerE5702374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 00:53:41 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 579D258050;
        Wed, 19 Oct 2022 00:53:40 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD03F58058;
        Wed, 19 Oct 2022 00:53:37 +0000 (GMT)
Received: from sig-9-65-232-148.ibm.com (unknown [9.65.232.148])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 19 Oct 2022 00:53:37 +0000 (GMT)
Message-ID: <3e2a42216662adb390831f98ea429a4245a4598a.camel@linux.ibm.com>
Subject: Re: [PATCH v4] KEYS: encrypted: fix key instantiation with
 user-provided data
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nikolaus Voss <nv@vosn.de>
Cc:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Yael Tzur <yaelt@google.com>,
        Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 18 Oct 2022 20:53:37 -0400
In-Reply-To: <1b621acf-a1f1-ec9b-21f6-d081d69ed74@vosn.de>
References: <20221013064308.857011E25@mail.steuer-voss.de>
          <924a29d81cc7e0d3e2f62f693a0d8fcef97b9779.camel@linux.ibm.com>
          <c620d6ed-d97f-b0c3-574-7b3cd63a7799@vosn.de>
         <16fe5265c49fcecdf613fe9dd660efe4ae8d452e.camel@linux.ibm.com>
         <1b621acf-a1f1-ec9b-21f6-d081d69ed74@vosn.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BS7bdyvuKodL2A6r7ZMgsg4VLNfM0MvT
X-Proofpoint-ORIG-GUID: RRwvLxu41O_L1FDqIztkxmhZnCWXqIaA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_09,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190000
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-10-14 at 13:39 +0200, Nikolaus Voss wrote:
> On Fri, 14 Oct 2022, Mimi Zohar wrote:
> > On Fri, 2022-10-14 at 08:40 +0200, Nikolaus Voss wrote:
> >> On Thu, 13 Oct 2022, Mimi Zohar wrote:
> >>> On Thu, 2022-10-13 at 08:39 +0200, Nikolaus Voss wrote:
> >>>> Commit cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided
> >>>> decrypted data") added key instantiation with user provided decrypted data.
> >>>> The user data is hex-ascii-encoded but was just memcpy'ed to the binary buffer.
> >>>> Fix this to use hex2bin instead.
> >>>>
> >>>> Old keys created from user provided decrypted data saved with "keyctl pipe"
> >>>> are still valid, however if the key is recreated from decrypted data the
> >>>> old key must be converted to the correct format. This can be done with a
> >>>> small shell script, e.g.:
> >>>>
> >>>> BROKENKEY=abcdefABCDEF1234567890aaaaaaaaaa
> >>>> NEWKEY=$(echo -ne $BROKENKEY | xxd -p -c32)
> >>>> keyctl add user masterkey "$(cat masterkey.bin)" @u
> >>>> keyctl add encrypted testkey "new user:masterkey 32 $NEWKEY" @u
> >>>>
> >>>> It is encouraged to switch to a new key because the effective key size
> >>>> of the old keys is only half of the specified size.
> >>>
> >>> Both the old and new decrypted data size is 32 bytes.  Is the above
> >>> statement necessary, especially since the Documentation example does
> >>> the equivalent?
> >>
> >> The old key has the same byte size but all bytes must be within the
> >> hex-ascíi range of characters, otherwise it is refused by the kernel.
> >> So if you wanted a 32 bytes key you get 16 effective bytes for the key.
> >> In the above example the string size of the $BROKENKEY is 32, while
> >> the string size of the $NEWKEY is 64.
> >>
> >> If you do
> >>
> >> $ echo $NEWKEY
> >> 6162636465664142434445463132333435363738393061616161616161616161
> >>
> >> for the example, the range problem is obvious, so $NEWKEY is still broken.
> >> That's why it should only be used to recover data which should be
> >> reencypted with a new key. If you count exactly, the effective key size is
> >> _slightly_ longer than half of the specified size, but it is still a
> >> severe security problem.
> >
> > So the issue with NEWKEY isn't the "effective key size of the old keys
> > is only half of the specified size", but that the old key, itself, is
> > limited to the hex-ascii range of characters.
> 
> The latter resulting in the former. If for BROKENKEY 32 bytes were 
> specified, a brute force attacker knowing the key properties would only 
> need to try at most 2^(16*8) keys, as if the key was only 16 bytes long. 
> This is what I mean with "effective size" in contrast to the key's byte 
> size which is 32 in my example.
> 
> The security issue is a result of the combination of limiting the input 
> range to hex-ascii and using memcpy() instead of hex2bin(). It could have 
> been fixed either by allowing binary input or using hex2bin() (and 
> doubling the ascii input key length). I chose the latter.

Agreed the latter is better solution.  Please update/replace the
sentence "It is encouraged to switch to a new key because ..." based on
this more complete explanation.

thanks,

Mimi

