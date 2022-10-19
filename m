Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A5B6051EE
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Oct 2022 23:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiJSV2l (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Oct 2022 17:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiJSV2l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Oct 2022 17:28:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E391192BAE;
        Wed, 19 Oct 2022 14:28:40 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JKwe7c001865;
        Wed, 19 Oct 2022 21:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=T+Jk7lIBu2l2PqGfyM5TiXTvwVNPyrBCjIxqykwErAg=;
 b=azGPoTCTzc/XulTUdCDmGimMu5O0FMEBZaFa5PRG+e/x1WxMdVE3Wy+L9g8GN4JUl/58
 TLlaI0gLWOMVqFCeL1dP9OUkkRQC/VZ9fwLB/SDNRgsOUNAaoUj6j4RIDB9B4mA4z7k9
 G/4QFU2faD+hrhLuzYCVR3ZY2J1beMZqSU5P3juHvS1W49YUqLL0I/RSYwrXjbMWTCRu
 0cMPZbMRL5E5RY1HH5pi4iaDWBZNB4oWWHVppVX92Av/DYLtJXJC2jithnZ14obqJIh1
 2QslicwRfzFnM53fY/0XRv+MmNoAFacHOcMuTx8bGwOEjaJOcpqKRXkt4u57GUb7MlMO Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3karreru4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 21:28:28 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29JKxaBT006991;
        Wed, 19 Oct 2022 21:28:27 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3karreru47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 21:28:27 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29JLLOkQ032247;
        Wed, 19 Oct 2022 21:28:26 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 3kapd5172t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 21:28:26 +0000
Received: from smtpav03.wdc07v.mail.ibm.com ([9.208.128.112])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29JLSP0810224374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 21:28:25 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED72858064;
        Wed, 19 Oct 2022 21:28:24 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A98865805D;
        Wed, 19 Oct 2022 21:28:23 +0000 (GMT)
Received: from sig-9-65-252-68.ibm.com (unknown [9.65.252.68])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 19 Oct 2022 21:28:23 +0000 (GMT)
Message-ID: <075b53e67638b4da85da9299b59fe2662a765c92.camel@linux.ibm.com>
Subject: Re: [PATCH v6] KEYS: encrypted: fix key instantiation with
 user-provided data
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nikolaus Voss <nikolaus.voss@haag-streit.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Yael Tzur <yaelt@google.com>,
        Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 19 Oct 2022 17:28:23 -0400
In-Reply-To: <20221019164526.B70DF1C59@mail.steuer-voss.de>
References: <20221019164526.B70DF1C59@mail.steuer-voss.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lV0UO2BnuYOufEOrGRi0JMUHPBvTgBh-
X-Proofpoint-ORIG-GUID: KqKrl-8AZ61n4skYQsj1DuzlQeHR67EB
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_12,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190117
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-10-19 at 18:38 +0200, Nikolaus Voss wrote:
> Commit cd3bc044af48 ("KEYS: encrypted: Instantiate key with
> user-provided decrypted data") added key instantiation with user
> provided decrypted data.  The user data is hex-ascii-encoded but was
> just memcpy'ed to the binary buffer. Fix this to use hex2bin instead.
> 
> Old keys created from user provided decrypted data saved with "keyctl
> pipe" are still valid, however if the key is recreated from decrypted
> data the old key must be converted to the correct format. This can be
> done with a small shell script, e.g.:
> 
> BROKENKEY=abcdefABCDEF1234567890aaaaaaaaaa
> NEWKEY=$(echo -ne $BROKENKEY | xxd -p -c32)
> keyctl add user masterkey "$(cat masterkey.bin)" @u
> keyctl add encrypted testkey "new user:masterkey 32 $NEWKEY" @u
> 
> However, NEWKEY is still broken: If for BROKENKEY 32 bytes were
> specified, a brute force attacker knowing the key properties would only
> need to try at most 2^(16*8) keys, as if the key was only 16 bytes long.
> 
> The security issue is a result of the combination of limiting the input
> range to hex-ascii and using memcpy() instead of hex2bin(). It could
> have been fixed either by allowing binary input or using hex2bin() (and
> doubling the ascii input key length). This patch implements the latter.
> 
> The corresponding test for the Linux Test Project ltp has also been
> fixed (see link below).
> 
> Fixes: cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided decrypted data")
> Cc: stable@kernel.org
> Link: https://lore.kernel.org/ltp/20221006081709.92303897@mail.steuer-voss.de/
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Nikolaus Voss <nikolaus.voss@haag-streit.com>

Thanks!  This patch is now queued in next-integrity/next-integrity-
testing.

-- 
thanks,

Mimi

