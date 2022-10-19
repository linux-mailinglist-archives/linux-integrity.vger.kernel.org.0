Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32BA604D77
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Oct 2022 18:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiJSQcJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Oct 2022 12:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiJSQcH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Oct 2022 12:32:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877D91AD82;
        Wed, 19 Oct 2022 09:32:03 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JGLrXP001457;
        Wed, 19 Oct 2022 16:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=0FemrlkL2zjvgkEKYy/s8nxfAGJ9llFtOVrJjesBs4c=;
 b=FI+kgbyjJfybtZOpTF5kniMetTPjZBM/CB7at9lRxhHB4Nd6CL0L4+rkHRmeNgZ811OB
 7ug6rtecywvfnfmvxvGjpwto7ZFWC8e7/2bl+wmmSNs1HLwO4IQAm2HqmUiUzmgRm9m3
 tUQtCqLlClkl6bK2lrdnc57P2ZwG5THImsF1ldqDN4R2zNMIYqehS0XamDVEM9HnP3Cw
 5GWAUxdpjpZi7NkAvCrqR9tfYEAe2HvsJ3/oCeylsuQZEihu8KlzuNhkYyZmMjw9yDv7
 /9RRT1PJSII+3JKV7Xa3Nlt5QrxW+UHA+Ib6gMctHEMuNoTC6kQatPAdpswfK5c0/gKo Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kampqraq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 16:31:54 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29JGM6kd002140;
        Wed, 19 Oct 2022 16:31:53 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kampqrapt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 16:31:53 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29JGKpse028105;
        Wed, 19 Oct 2022 16:31:52 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01dal.us.ibm.com with ESMTP id 3k7mg9bjrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 16:31:52 +0000
Received: from smtpav06.wdc07v.mail.ibm.com ([9.208.128.115])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29JGVpWr43254254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 16:31:51 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 698FB58055;
        Wed, 19 Oct 2022 16:31:50 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47C0258056;
        Wed, 19 Oct 2022 16:31:49 +0000 (GMT)
Received: from sig-9-65-252-68.ibm.com (unknown [9.65.252.68])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 19 Oct 2022 16:31:49 +0000 (GMT)
Message-ID: <230c9c42995e52174b8503b05f0c51225ad0aeca.camel@linux.ibm.com>
Subject: Re: [PATCH v5] KEYS: encrypted: fix key instantiation with
 user-provided data
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nikolaus Voss <nv@vosn.de>, David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Yael Tzur <yaelt@google.com>,
        Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 19 Oct 2022 12:31:47 -0400
In-Reply-To: <20221019141031.E605D1B3B@mail.steuer-voss.de>
References: <20221019141031.E605D1B3B@mail.steuer-voss.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7UGECKheJno6Xp8SpPP1z9gKWj1k9Ng6
X-Proofpoint-ORIG-GUID: ao8WAIor37KsT8KpDy2Wbdnn4z8tH1EV
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_09,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190091
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Nikolaus,

On Wed, 2022-10-19 at 16:07 +0200, Nikolaus Voss wrote:
> Commit cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided
> decrypted data") added key instantiation with user provided decrypted data.
> The user data is hex-ascii-encoded but was just memcpy'ed to the binary buffer.
> Fix this to use hex2bin instead.
> 
> Old keys created from user provided decrypted data saved with "keyctl pipe"
> are still valid, however if the key is recreated from decrypted data the
> old key must be converted to the correct format. This can be done with a
> small shell script, e.g.:
> 
> BROKENKEY=abcdefABCDEF1234567890aaaaaaaaaa
> NEWKEY=$(echo -ne $BROKENKEY | xxd -p -c32)
> keyctl add user masterkey "$(cat masterkey.bin)" @u
> keyctl add encrypted testkey "new user:masterkey 32 $NEWKEY" @u
> 
> However, NEWKEY is still broken: If for BROKENKEY 32 bytes were specified, a
> brute force attacker knowing the key properties would only need to try at most
> 2^(16*8) keys, as if the key was only 16 bytes long.
> 
> The security issue is a result of the combination of limiting the input range
> to hex-ascii and using memcpy() instead of hex2bin(). It could have been fixed
> either by allowing binary input or using hex2bin() (and doubling the ascii
> input key length). This patch implements the latter.
> 
> The corresponding test for the Linux Test Project ltp has also been
> fixed (see link below).
> 
> Fixes: cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided decrypted data")
> Cc: stable <stable@kernel.org>
> Link: https://lore.kernel.org/ltp/20221006081709.92303897@mail.steuer-voss.de/
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Nikolaus Voss <nikolaus.voss@haag-streit.com>

While preparing to queue this patch, I noticed scripts/checkpatch.pl
returns a couple of warnings, including that the sender email address
and your tag here don't match.  Wish I had caught them earlier.
-- 
thanks,

Mimi

