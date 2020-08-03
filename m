Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C163323ABA0
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Aug 2020 19:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgHCR0c (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Aug 2020 13:26:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726398AbgHCR0c (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Aug 2020 13:26:32 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 073H1eSx146076;
        Mon, 3 Aug 2020 13:26:27 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32png82cyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 13:26:27 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 073H1hQo146201;
        Mon, 3 Aug 2020 13:26:26 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32png82cy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 13:26:26 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 073HNEDQ010665;
        Mon, 3 Aug 2020 17:26:24 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 32mynh9fn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 17:26:24 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 073HQM0x61931834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Aug 2020 17:26:22 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB80C11C050;
        Mon,  3 Aug 2020 17:26:21 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D871F11C04C;
        Mon,  3 Aug 2020 17:26:20 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.52.50])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  3 Aug 2020 17:26:20 +0000 (GMT)
Message-ID: <01efbe7c9a9cc9624785bcc9085866d8c0f4f4d3.camel@linux.ibm.com>
Subject: Re: [ima-evm-utils: PATCH 5/5] ima-evm-utils: travis: openssl gost
 engine
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>, Petr Vorel <pvorel@suse.cz>
Cc:     linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Date:   Mon, 03 Aug 2020 13:26:19 -0400
In-Reply-To: <20200731210653.p5m4efy52melqwgs@altlinux.org>
References: <20200731182408.696931-1-zohar@linux.ibm.com>
         <20200731182408.696931-6-zohar@linux.ibm.com>
         <20200731185633.kqgcz4dwfa4ruyld@altlinux.org>
         <20200731201808.GA27841@dell5510>
         <20200731202638.x5mnkz7hcpgbveu2@altlinux.org>
         <20200731204044.GC27841@dell5510>
         <20200731210653.p5m4efy52melqwgs@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-03_15:2020-08-03,2020-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=987 adultscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008030121
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2020-08-01 at 00:06 +0300, Vitaly Chikunov wrote:
> On Fri, Jul 31, 2020 at 10:40:44PM +0200, Petr Vorel wrote:
> > And when using suggested branch openssl_1_1_0, it also fails on make install
> > $ ./tests/install-gost-engine.sh
> > OpenSSL 1.1.1g  21 Apr 2020
> > Cloning into 'engine'...
> > remote: Enumerating objects: 63, done.
> > remote: Counting objects: 100% (63/63), done.
> > remote: Compressing objects: 100% (40/40), done.
> > remote: Total 2738 (delta 33), reused 32 (delta 21), pack-reused 2675
> > Receiving objects: 100% (2738/2738), 2.48 MiB | 2.09 MiB/s, done.
> > Resolving deltas: 100% (1735/1735), done.
> > -- The C compiler identification is GNU 10.1.1
> > -- Detecting C compiler ABI info
> > -- Detecting C compiler ABI info - done
> > -- Check for working C compiler: /usr/bin/cc - skipped
> > -- Detecting C compile features
> > -- Detecting C compile features - done
> > -- Found OpenSSL: /usr/lib64/libcrypto.so (found suitable version "1.1.1g", minimum required is "1.1")
> > -- Check if the system is big endian
> > -- Searching 16 bit integer
> > -- Looking for sys/types.h
> > -- Looking for sys/types.h - found
> > -- Looking for stdint.h
> > -- Looking for stdint.h - found
> > -- Looking for stddef.h
> > -- Looking for stddef.h - found
> > -- Check size of unsigned short
> > -- Check size of unsigned short - done
> > -- Searching 16 bit integer - Using unsigned short
> > -- Check if the system is big endian - little endian
> > -- LITTLE_ENDIAN
> > -- Configuring done
> > -- Generating done
> > -- Build files have been written to: /home/pvorel/install/src/ima-evm-utils.git/engine
> > make: *** No rule to make target 'install'.  Stop.
> 
> It seems this branch does not have install target. I think,
> 
> - `engine/bin/gost.so` should be moved in platform dependent engines dir,
> for example for debian9 it's `/usr/lib/x86_64-linux-gnu/engines-1.1/`
> (found with strace).
> 
> - Or, just keep it as is, but `OPENSSL_ENGINES` env should be set to
> `/home/pvorel/install/src/ima-evm-utils.git/engine/bin/`.
> 
> - Or even better, Bionic (which is supported by Travis) should have
>   gost-engine already in the libengine-gost-openssl1.1 package.
> 
>   In that case `.travis.yml` should have `dist: bionic`.
>     https://docs.travis-ci.com/user/reference/bionic/

Petr, Vitaly, so I should drop  "ima-evm-utils: travis: openssl gost
engine" and add "dist: bionic" instead?

Mimi

