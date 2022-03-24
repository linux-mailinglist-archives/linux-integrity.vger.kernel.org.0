Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A0C4E65E1
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Mar 2022 16:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351282AbiCXPQe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Mar 2022 11:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351312AbiCXPQ0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Mar 2022 11:16:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C7A6CA63
        for <linux-integrity@vger.kernel.org>; Thu, 24 Mar 2022 08:14:54 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22OFAXP5031754;
        Thu, 24 Mar 2022 15:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=SDBb7pAgT8zDKSsHxMM983wxvqD/A2yBHic4brxt2Rw=;
 b=o2w/OFM25ELjcRPgo+k0lwklUTLtz6USsQpk5OnE+/TkMSIsZNixNeS/dl1PsB8wowck
 HTDSKnEM66MksizVen9DEpJTtcOmuo99M85/ziPt+ciuGsw9DZnU02T6wPMD+NB59j0u
 5SNWCFiq+4bss/F7jNmGdgqpFgBbJNdeAJBERkSAE5KZqNsHHcZpfHDdb+JiaiYPEd+j
 /a0GnZKW54Hl5bjh6vhZgde7Vx1ITLFY1Cs7osWTmTYxTDoTG8noKVlifb9wcXuAhplJ
 eLzE1mMLCoeSr3mrTPMKgjiWjrpwucdmeMjICZf6CSBCcCox+HxJFl9O72l5uAFHeyse Mw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f0p8myggw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Mar 2022 15:14:50 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22OF7aa1030461;
        Thu, 24 Mar 2022 15:14:48 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3ew6t935px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Mar 2022 15:14:47 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22OFEjUf40501648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 15:14:45 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A32E84203F;
        Thu, 24 Mar 2022 15:14:45 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34EF342042;
        Thu, 24 Mar 2022 15:14:45 +0000 (GMT)
Received: from sig-9-65-85-58.ibm.com (unknown [9.65.85.58])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 24 Mar 2022 15:14:45 +0000 (GMT)
Message-ID: <b0187376bd137f7b6ffee141227b28a04ffc015a.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] travis: include CentOS stream 8
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-integrity@vger.kernel.org
Date:   Thu, 24 Mar 2022 11:14:44 -0400
In-Reply-To: <Yjx8RWbYwYV0ihKK@pevik>
References: <20220323233057.42287-1-zohar@linux.ibm.com>
         <Yjx8RWbYwYV0ihKK@pevik>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mhMix2AdibS-wgv1lMMyIMuf_M0D76yV
X-Proofpoint-GUID: mhMix2AdibS-wgv1lMMyIMuf_M0D76yV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-24_04,2022-03-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203240085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-03-24 at 15:12 +0100, Petr Vorel wrote:
> Hi Mimi,
> 
> > Replace CentOS 8 with CentOS stream 8.
> > Use podman for both CentOS 7 & 8.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks, Petr.  The three CI changes are now queued in next-testing.
> 
> What a shame that GitHub Actions cannot specify container.

Looking on the bright side, at least we didn't remove the travis
support.   Below are a few of the "centos:stream9" compiler warnings
and runtime errors.

Build:
evmctl.c:955:2: warning: 'RSA_free' is deprecated [-Wdeprecated-
declarations]
        RSA_free(key);

evmctl.c:1096:9: warning: 'HMAC_CTX_new' is deprecated [-Wdeprecated-
declarations]
        pctx = HMAC_CTX_new();
        ^
evmctl.c:2249:3: warning: 'SHA1_Init' is deprecated [-Wdeprecated-
declarations]
                SHA1_Init(&c);

evmctl.c:2646:16: warning: 'ENGINE_by_id' is deprecated [-Wdeprecated-
declarations]
        ENGINE *eng = ENGINE_by_id(engine_id);


Rruntime:

evmctl -v  ima_verify --key test-rsa1024.pub --xattr-user --sigfile
sha256.txt
  Failed to d2i_X509_fp key file: test-rsa1024.pub
  openssl: error:068000A8:asn1 encoding routines::wrong tag
  openssl: error:0688010A:asn1 encoding routines::nested asn1 error

sha1 (test-rsa1024.key) test is skipped (openssl is unable to sign)

evmctl -v  verify --key test-rsa1024.pub --xattr-user --rsa --uuid --
generation 0 sha256.txt
evmctl verify failed properly with (125) 

sha1 (test-prime192v1.key) test is skipped (key file not found)
- openssl dgst   -sha1 sha1.txt
sha1 (test-prime192v1.key) test is skipped (key file not found)
- openssl dgst   -sha224 sha224.txt
sha224 (test-prime192v1.key) test is skipped (key file not found)
- openssl dgst   -sha224 sha224.txt
sha224 (test-prime192v1.key) test is skipped (key file not found)
- openssl dgst   -sha256 sha256.txt
sha256 (test-prime192v1.key) test is skipped (key file not found)
- openssl dgst   -sha256 sha256.txt
sha256 (test-prime192v1.key) test is skipped (key file not found)
- openssl dgst   -sha384 sha384.txt
sha384 (test-prime192v1.key) test is skipped (key file not found)
- openssl dgst   -sha384 sha384.txt
sha384 (test-prime192v1.key) test is skipped (key file not found)
- openssl dgst   -sha512 sha512.txt
sha512 (test-prime192v1.key) test is skipped (key file not found)
- openssl dgst   -sha512 sha512.txt
sha512 (test-prime192v1.key) test is skipped (key file not found)
- openssl dgst   -sha1 sha1.txt
- openssl dgst   -sha1 -sign test-prime256v1.key -hex sha1.txt

-- 
thanks,

Mimi

