Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3643BE0E0
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 04:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhGGCbc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jul 2021 22:31:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229894AbhGGCbc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jul 2021 22:31:32 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16724BKF161710;
        Tue, 6 Jul 2021 22:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=5eptId6Ggabl/j1W5AWVj9Q3iOsyZSyzxAE+RiVK7KQ=;
 b=fT+IMTOUZuizoarsR1hESoGFSqXqCoEfNkJ7cW8qT36GD2MbdWTgvnJ00kMw6RbHS6C7
 568XXnUOTPksL1dcL5NVZI6pqiSV9XJJE/P7+vFhyMXu2lDQHOzwY1iOJE5mlz6cUlji
 WFI1m7T+QKNAAJPd+8ZXOHuwPbpidPG2V5cPqmbA9Ii6DItjpdEIsjPlivgcp7f5GA3L
 KLyz5yN7G3Fe869HvfcKbObUNC3QNF69HE6BVXBtyvNcwqgGRq8yK9ZC4HedWTHXhM2U
 E7x02xebVvoExOjpGXIz7HA4Af4Y5aDjqJdfzspp4kEoZFzom0ZcKZScPaWDu2xFCIiz ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39m8xte4vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jul 2021 22:28:50 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1672Po2Y026742;
        Tue, 6 Jul 2021 22:28:50 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39m8xte4vg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jul 2021 22:28:50 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1672Qq9a000785;
        Wed, 7 Jul 2021 02:28:48 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 39jfh8sgf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 02:28:48 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1672QtLL37224738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Jul 2021 02:26:55 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 172B0A405C;
        Wed,  7 Jul 2021 02:28:46 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E72DAA405B;
        Wed,  7 Jul 2021 02:28:44 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.34.2])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  7 Jul 2021 02:28:44 +0000 (GMT)
Message-ID: <10f55257f543cc1d63e7a8ae36cbf2433a01c30b.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v3] ima-evm-utils: Support SM2 algorithm
 for sign and verify
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Date:   Tue, 06 Jul 2021 22:28:44 -0400
In-Reply-To: <d7526f84-f7c9-cbc6-c4a5-3e8b8d78fb60@linux.alibaba.com>
References: <20210526084455.56705-1-tianjia.zhang@linux.alibaba.com>
         <d7526f84-f7c9-cbc6-c4a5-3e8b8d78fb60@linux.alibaba.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BWEWyAj6cwRrTD2qSQs7fOoF89wU0FLS
X-Proofpoint-GUID: aXZaW9oSP1DO4FYVHQNDfBYaTxDP4o1u
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-06_13:2021-07-06,2021-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107070009
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-07-02 at 11:18 +0800, Tianjia Zhang wrote:
> Hi,
> 
> Any comment?

Except for a few older distros, Travis complains:

 openssl dgst  -sm3 sm3-hash.txt
+ evmctl -v  ima_hash --hashalgo sm3 --xattr-user sm3-hash.txt
  hash(sm3):
04111ab21d8355cfa17f8e61194831e81a8f22bec8c728fefb747ed035eb5082aa2b
Did not find expected hash for sm3:
    user.ima=0x011ab21d8355cfa17f8e61194831e81a8f22bec8c728fefb747ed035
eb5082aa2b
Actual output below:
    # file: sm3-hash.txt
    user.ima=0x04111ab21d8355cfa17f8e61194831e81a8f22bec8c728fefb747ed0
35eb5082aa2b 

> > diff --git a/tests/gen-keys.sh b/tests/gen-keys.sh
> > index 46130cf..a75dc2e 100755
> > --- a/tests/gen-keys.sh
> > +++ b/tests/gen-keys.sh
> > @@ -112,6 +112,28 @@ for m in \
> >       fi
> >   done
> >   
> > +# SM2
> > +for curve in sm2; do
> > +  if [ "$1" = clean ] || [ "$1" = force ]; then
> > +    rm -f test-$curve.cer test-$curve.key test-$curve.pub
> > +  fi
> > +  if [ "$1" = clean ]; then
> > +    continue
> > +  fi
> > +  if [ ! -e test-$curve.key ]; then
> > +    log openssl req -verbose -new -nodes -utf8 -days 10000 -batch -x509 \
> > +      -sm3 -sigopt "distid:1234567812345678" \
> > +      -config test-ca.conf \
> > +      -copy_extensions copyall \
> > +      -newkey $curve \
> > +      -out test-$curve.cer -outform DER \
> > +      -keyout test-$curve.key
> > +    if [ -s test-$curve.key ]; then
> > +      log openssl pkey -in test-$curve.key -out test-$curve.pub -pubout
> > +    fi
> > +  fi
> > +done

I'm also seeing:
- openssl req -verbose -new -nodes -utf8 -days 10000 -batch -x509 -sm3
-sigopt distid:1234567812345678 -config test-ca.conf -copy_extensions
copyall -newkey sm2 -out test-sm2.cer -outform DER -keyout test-sm2.key
req: Unrecognized flag copy_extensions

thanks,

Mimi

