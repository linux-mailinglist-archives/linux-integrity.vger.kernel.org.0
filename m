Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805D35BF09D
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Sep 2022 00:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiITWyo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Sep 2022 18:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiITWyk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Sep 2022 18:54:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881595F6F;
        Tue, 20 Sep 2022 15:54:38 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KLwIIA003520;
        Tue, 20 Sep 2022 22:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=oYK6TumnSDP79KmzKKCHc3Thiq4B9cnHKK0N6TQXz+s=;
 b=FhdIKnds4/ao8gluJUUTb1j643R16U4ZzzCFuEBzbK7q6NgHDgVAroZPWoPcAAThYSML
 YTOUFMWJUKh2Xx6aa+U97kABfaNJniT9+Hg4ii5FZpa7/ncXhqmxY01o8GjNxOjShbyF
 u7uZ4xIybt7enlNpbzXt+H7SxDbxOX8thC93Cdrq2tNtLMOPRrN0pJbuKjfbTNVr4khE
 UE2NYYRWSKI+rbaJF66rY1NohczIcFh9YUc3+ycqDud4stskYZYuh3sZgPJipboeLkvJ
 RTU29ZkRF8+1MSlkLzKXcishroFxyuv+wHvmF/+ATYatmaRTxhzZoUs5h01R9LYI7yLI Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jqnsba0x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 22:54:20 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28KMluq0007777;
        Tue, 20 Sep 2022 22:54:19 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jqnsba0wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 22:54:19 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28KMsIhI028635;
        Tue, 20 Sep 2022 22:54:18 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma02dal.us.ibm.com with ESMTP id 3jn5v9v3ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 22:54:18 +0000
Received: from smtpav03.wdc07v.mail.ibm.com ([9.208.128.112])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28KMrobw63308110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 22:53:51 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2D8758054;
        Tue, 20 Sep 2022 22:53:50 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A61E35805D;
        Tue, 20 Sep 2022 22:53:49 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.97.163])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 20 Sep 2022 22:53:49 +0000 (GMT)
Message-ID: <2ee1e3e68d847001c4bf856d980a553e52de5023.camel@linux.ibm.com>
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
Date:   Tue, 20 Sep 2022 18:53:49 -0400
In-Reply-To: <35fd816-d755-967-5712-b5496875ac7a@vosn.de>
References: <20220919072317.E41421357@mail.steuer-voss.de>
         <53730789a41358673b1715dd650706e9ffcb1199.camel@linux.ibm.com>
         <35fd816-d755-967-5712-b5496875ac7a@vosn.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sMx5z6293e_ehcWEkD1Jlqlmse1KmUDC
X-Proofpoint-ORIG-GUID: _UECJhX_Ua7HB6pA3Bmwjo68ZckAq3up
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_10,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200137
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-09-20 at 18:23 +0200, Nikolaus Voss wrote:
> On Tue, 20 Sep 2022, Mimi Zohar wrote:
> > On Fri, 2022-09-16 at 07:45 +0200, Nikolaus Voss wrote:
> >> Commit cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided
> >> decrypted data") added key instantiation with user provided decrypted data.
> >> The user data is hex-ascii-encoded but was just memcpy'ed to the binary buffer.
> >> Fix this to use hex2bin instead.
> >
> > Thanks, Nikolaus.  We iterated a number of times over what would be the
> > safest userspace input.  One of the last changes was that the key data
> > should be hex-ascii-encoded.  Unfortunately, the LTP
> > testcases/kernel/syscalls/keyctl09.c example isn't hex-ascii-encoded
> > and the example in Documentation/security/keys/trusted-encrypted.rst
> > just cat's a file.  Both expect the length to be the length of the
> > userspace provided data.   With this patch, when hex2bin() fails, there
> > is no explanation.
> 
> That's true. But it's true for all occurrences of hex2bin() in this file.
> I could pr_err() an explanation, improve the trusted-encrypted.rst example 
> and respin the patch. Should I, or do you have another suggestion?

> I wasn't aware of keyctl09.c, but quickly looking into it, the user data 
> _is_ hex-ascii-encoded, only the length is "wrong": Imho, the specified 
> length should be the binary length as this is consistent with key-length 
> specs in other cases (e.g. when loading the key from a blob).
> keyctl09.c could be easy to fix, if only the length is modified. Should 
> I propose a patch? What is the correct/appropriate workflow there?

I'm concerned that this change breaks existing encrypted keys created
with user-provided data.  Otherwise I'm fine with your suggestion.

The LTP example decrypted data length is 32, but the minimum decrypted
data size is  20.  So it's a bit more than just changing the LTP
decrypted data size.   The modified LTP test should work on kernels
with and without this patch.

-- 
thanks,

Mimi

