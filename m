Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AC05FE6D7
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Oct 2022 04:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJNCLQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Oct 2022 22:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJNCLQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Oct 2022 22:11:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6EAE5ECC;
        Thu, 13 Oct 2022 19:11:14 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29E0YwTX021621;
        Fri, 14 Oct 2022 02:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Nvz7VZjslcrs0TPXWLB8CTDZ5OZTDPnEaQ2gefzJEqI=;
 b=AHuqbLVejDlEtFy0vMYXYyYCj/k2RxmTJSdTTljpEzpUvCJoVGrNAvq8GQh37aRTa03h
 VRC+N2j3ENBmqS33AOeH93C9uMvaeBcIg89EgkhczKlQvl1199B4vSuOMS/jz6eEDLY+
 YHpWs4aRUw+jQJIwLax5qyK+OFOuQbemm1tIWg10ALnXfDa3mGgTVADAm6am0R6IXpvu
 Q3mdkDO/m8C+wzqGj0wAzvwI66vCPLSeiDjC/wbF9b6JkwzDI/DW7bJV1msa6Og8ohy4
 W5k8FU1Rlra0tuiPqftSq+hozBogW43kl6o6LaWrmIEeUQF9XCLJwBX6DfOIu0NPSm3n wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k6gw1gtum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 02:10:58 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29E2AwRf010044;
        Fri, 14 Oct 2022 02:10:58 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k6gw1gtu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 02:10:58 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29E26bsY015001;
        Fri, 14 Oct 2022 02:10:57 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01dal.us.ibm.com with ESMTP id 3k6kcmhh0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 02:10:57 +0000
Received: from smtpav06.dal12v.mail.ibm.com ([9.208.128.130])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29E2Av9Z53150202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 02:10:57 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84E8A5805E;
        Fri, 14 Oct 2022 02:10:55 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C086458043;
        Fri, 14 Oct 2022 02:10:54 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.3.142])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 14 Oct 2022 02:10:54 +0000 (GMT)
Message-ID: <924a29d81cc7e0d3e2f62f693a0d8fcef97b9779.camel@linux.ibm.com>
Subject: Re: [PATCH v4] KEYS: encrypted: fix key instantiation with
 user-provided data
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nikolaus Voss <nv@vosn.de>, David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Yael Tzur <yaelt@google.com>,
        Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 13 Oct 2022 22:10:54 -0400
In-Reply-To: <20221013064308.857011E25@mail.steuer-voss.de>
References: <20221013064308.857011E25@mail.steuer-voss.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6Rh3Y9hxAo8XJpsQtvJeqnFS7ykqp-qJ
X-Proofpoint-GUID: 9Je1RXEcqirXsf96tPUF5ND7WkOV21mV
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_10,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210140010
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-10-13 at 08:39 +0200, Nikolaus Voss wrote:
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
> It is encouraged to switch to a new key because the effective key size
> of the old keys is only half of the specified size.

Both the old and new decrypted data size is 32 bytes.  Is the above
statement necessary, especially since the Documentation example does
the equivalent?

> The corresponding test for the Linux Test Project ltp has also been
> fixed (see link below).

The LTP patch still needs to be revised, but the "Link" is a reference
to the discussion.  Is the above statement necessary?

> 
> Fixes: cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided decrypted data")
> Cc: stable <stable@kernel.org>
> Link: https://lore.kernel.org/ltp/20221006081709.92303897@mail.steuer-voss.de/
> Signed-off-by: Nikolaus Voss <nikolaus.voss@haag-streit.com>

Otherwise,

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

