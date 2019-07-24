Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8F8E74167
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jul 2019 00:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfGXW2T (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jul 2019 18:28:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726486AbfGXW2S (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jul 2019 18:28:18 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6OMQbCc122379
        for <linux-integrity@vger.kernel.org>; Wed, 24 Jul 2019 18:28:17 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2txwjg5mwa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 24 Jul 2019 18:28:17 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 24 Jul 2019 23:28:15 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 24 Jul 2019 23:28:11 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6OMSBsq39125068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 22:28:11 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E35DC52063;
        Wed, 24 Jul 2019 22:28:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.82.197])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3430652052;
        Wed, 24 Jul 2019 22:28:10 +0000 (GMT)
Subject: Re: ima-evm-utils:  library version
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>, Petr Vorel <pvorel@suse.cz>,
        "BrunoE.O.Meneguele" <bmeneg@redhat.com>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date:   Wed, 24 Jul 2019 18:27:59 -0400
In-Reply-To: <20190724191733.466tex2pqoikmyfl@altlinux.org>
References: <1563972698.4245.21.camel@linux.ibm.com>
         <20190724172801.y64bs2byyuqfsezf@altlinux.org>
         <20190724191733.466tex2pqoikmyfl@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19072422-4275-0000-0000-000003504267
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072422-4276-0000-0000-000038606C14
Message-Id: <1564007279.4245.59.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-24_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907240240
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-07-24 at 22:17 +0300, Vitaly Chikunov wrote:
> Btw,
> 
> On Wed, Jul 24, 2019 at 08:28:01PM +0300, Vitaly Chikunov wrote:
> > On Wed, Jul 24, 2019 at 08:51:38AM -0400, Mimi Zohar wrote:
> > > 
> > > In preparing the ima-evm-utils v1.2 release, I noticed that the
> > > library version was never updated.  It is still "0.0.0".  Should I set
> > > it to something?  If so, what versioning scheme do you recommend -
> > > using the libtool current[:revision[:age]], prepending the release
> > > version on the .so, or suffixing the release version on the .so?
> > 
> > libtool rules should be followed:
> > 
> >   https://www.gnu.org/software/libtool/manual/html_node/Updating-version-info.html
> > 
> > I think you should change 0.0.0 to 1.0.0 just before release. Since we are
> > changed ABI of calc_keyid_v2 (RSA *key -> EVP_PKEY *pkey). (There is also
> > changes to read_pub_pkey and get_filesize.)
> 
> Speaking about ABI:
> 
>    src/ima-evm-utils (tests)$ readelf --dyn-syms src/.libs/libimaevm.so | egrep -vw 'UND|_edata|_fini|_init|_end|__bss_start'
>    Num:    Value          Size Type    Bind   Vis      Ndx Name
>     74: 0000000000003bf6  1047 FUNC    GLOBAL DEFAULT   12 sign_hash_v1
>     75: 0000000000002c5b   783 FUNC    GLOBAL DEFAULT   12 read_pub_pkey
>     77: 000000000000400d   836 FUNC    GLOBAL DEFAULT   12 sign_hash_v2
>     78: 0000000000004351    56 FUNC    GLOBAL DEFAULT   12 sign_hash
>     81: 0000000000003795   198 FUNC    GLOBAL DEFAULT   12 key2bin
>     83: 00000000000025f3  1640 FUNC    GLOBAL DEFAULT   12 ima_calc_hash
>     84: 0000000000003204   232 FUNC    GLOBAL DEFAULT   12 get_hash_algo
>     85: 00000000000032ec   836 FUNC    GLOBAL DEFAULT   12 verify_hash
>     87: 0000000000003630   357 FUNC    GLOBAL DEFAULT   12 ima_verify_signature
>     88: 000000000000385b   204 FUNC    GLOBAL DEFAULT   12 calc_keyid_v1
>     89: 0000000000205d20   144 OBJECT  GLOBAL DEFAULT   20 hash_algo_name
>     90: 0000000000003927   308 FUNC    GLOBAL DEFAULT   12 calc_keyid_v2
>     91: 0000000000002566    34 FUNC    GLOBAL DEFAULT   12 dump
>     92: 0000000000003a5b   411 FUNC    GLOBAL DEFAULT   12 init_public_keys
>     93: 0000000000205c80   160 OBJECT  GLOBAL DEFAULT   20 pkey_hash_algo
>     94: 00000000002062c0    32 OBJECT  GLOBAL DEFAULT   24 params
>     95: 0000000000205be0   160 OBJECT  GLOBAL DEFAULT   20 pkey_hash_algo_kern
>     96: 0000000000002588   107 FUNC    GLOBAL DEFAULT   12 get_hash_algo_by_id
>     97: 0000000000002f6a   113 FUNC    GLOBAL DEFAULT   12 read_pub_key
>     98: 0000000000002509    93 FUNC    GLOBAL DEFAULT   12 do_dump
> 
> This looks not very good. Names like `dump', `do_dump', `params' aren't good
> for public ABI. And should be prefixed, or removed. Probably, some (or all)
> others too. Prefix could be something like `ima_', like in `ima_calc_hash'.

At least sign_hash_v1() and sign_hash_v2() can be addressed by making
them static.  Looking to see if there are others.

Mimi

