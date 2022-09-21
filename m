Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B235BFE63
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Sep 2022 14:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiIUMvu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Sep 2022 08:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiIUMva (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Sep 2022 08:51:30 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA797E305;
        Wed, 21 Sep 2022 05:49:45 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28LChkEK022742;
        Wed, 21 Sep 2022 12:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=RPrhIYPH7SzVN6HwjOBFFXL4u49GpdB6I2XBq1Lzios=;
 b=ksxJ7iqOtnmfOauEV0J6gaCR9a0PVfkifEskPjrsdzCGoHYtjL+mu6/rZ90yT1hBt2+q
 TW5rKaXjOmewP4wRiiuZGHf9Hf4bVH0PiNL5oOllhUd5s8oiCzyaJU0ktIYJHDU0wgcR
 53e6S/s1hNoBmz0pNs3NzfoxECP8QH50f5eKVaH7+eL6CvZG6Pim4xS6Tu45QENFwS28
 qsEAb1i/jaVoFdPNgiD/j+xV5QmZp6kjq2RkbI1yCeezIOHo+tRKeZferhEm+2wOSytn
 jVgKfvJD/3kfeTpSb5nUtdQF9DO3nbUFRixrxy3wsSbRWFPeSkYML0nHZPePlEF8wIUl 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jr2veg4rb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Sep 2022 12:49:39 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28LCmAe4007649;
        Wed, 21 Sep 2022 12:49:38 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jr2veg4qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Sep 2022 12:49:38 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28LCaKPb027788;
        Wed, 21 Sep 2022 12:49:37 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01dal.us.ibm.com with ESMTP id 3jn5va0ea4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Sep 2022 12:49:37 +0000
Received: from smtpav04.dal12v.mail.ibm.com ([9.208.128.131])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28LCnZb412518080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Sep 2022 12:49:35 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E55E55805E;
        Wed, 21 Sep 2022 12:49:35 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CE225804E;
        Wed, 21 Sep 2022 12:49:35 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.107.198])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 21 Sep 2022 12:49:35 +0000 (GMT)
Message-ID: <6b4229386dced275f745619f190f64a71b7c0aec.camel@linux.ibm.com>
Subject: Re: [PATCH] KEYS: encrypted: fix key instantiation with
 user-provided data
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nikolaus Voss <nv@vosn.de>
Cc:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yael Tzur <yaelt@google.com>
Date:   Wed, 21 Sep 2022 08:49:34 -0400
In-Reply-To: <439012d8-dd4-7fd2-3788-49cf72faa99@vosn.de>
References: <20220919072317.E41421357@mail.steuer-voss.de>
          <53730789a41358673b1715dd650706e9ffcb1199.camel@linux.ibm.com>
          <35fd816-d755-967-5712-b5496875ac7a@vosn.de>
         <2ee1e3e68d847001c4bf856d980a553e52de5023.camel@linux.ibm.com>
         <439012d8-dd4-7fd2-3788-49cf72faa99@vosn.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2dY3ILXBob7WRe2aAeF3SYN3PuTWn9EX
X-Proofpoint-ORIG-GUID: e-nAJ2Xvwd5N_o5uMkmNTOSwLwSp7gS1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_06,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209210086
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-09-21 at 09:24 +0200, Nikolaus Voss wrote:
> On Tue, 20 Sep 2022, Mimi Zohar wrote:
> > On Tue, 2022-09-20 at 18:23 +0200, Nikolaus Voss wrote:
> >> On Tue, 20 Sep 2022, Mimi Zohar wrote:
> >>> On Fri, 2022-09-16 at 07:45 +0200, Nikolaus Voss wrote:
> >>>> Commit cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided
> >>>> decrypted data") added key instantiation with user provided decrypted data.
> >>>> The user data is hex-ascii-encoded but was just memcpy'ed to the binary buffer.
> >>>> Fix this to use hex2bin instead.
> >>>
> >>> Thanks, Nikolaus.  We iterated a number of times over what would be the
> >>> safest userspace input.  One of the last changes was that the key data
> >>> should be hex-ascii-encoded.  Unfortunately, the LTP
> >>> testcases/kernel/syscalls/keyctl09.c example isn't hex-ascii-encoded
> >>> and the example in Documentation/security/keys/trusted-encrypted.rst
> >>> just cat's a file.  Both expect the length to be the length of the
> >>> userspace provided data.   With this patch, when hex2bin() fails, there
> >>> is no explanation.
> >>
> >> That's true. But it's true for all occurrences of hex2bin() in this file.
> >> I could pr_err() an explanation, improve the trusted-encrypted.rst example
> >> and respin the patch. Should I, or do you have another suggestion?
> >
> >> I wasn't aware of keyctl09.c, but quickly looking into it, the user data
> >> _is_ hex-ascii-encoded, only the length is "wrong": Imho, the specified
> >> length should be the binary length as this is consistent with key-length
> >> specs in other cases (e.g. when loading the key from a blob).
> >> keyctl09.c could be easy to fix, if only the length is modified. Should
> >> I propose a patch? What is the correct/appropriate workflow there?
> >
> > I'm concerned that this change breaks existing encrypted keys created
> > with user-provided data.  Otherwise I'm fine with your suggestion.
> 
> Ok, but this change does not touch the hex-ascii format of encrypted key 
> blobs?

True, but any persistent data based on this key would be affected.

> 
> >
> > The LTP example decrypted data length is 32, but the minimum decrypted
> > data size is  20.  So it's a bit more than just changing the LTP
> > decrypted data size.   The modified LTP test should work on kernels
> > with and without this patch.
> 
> So this would mean OR-ing old and new variant for the test?
> 
> The current implementation of the test will fail anyway as the key size is 
> below the minimum of 20 and thus should have failed before.

The existing keyctl09 test is a plain text string.  Converting it to
hex-ascii (e.g. hexdump, xdd) solves the length issue.  For those
already using encrypted keys with user provided data, this might also
resolve the persistent data usage case mentioned above.

Perhaps keep the existing test.  On success issue a warning.  On
failure, retry with the converted plain text string.

-- 
thanks,

Mimi

