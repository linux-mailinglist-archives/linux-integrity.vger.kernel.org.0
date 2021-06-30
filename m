Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71893B872E
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Jun 2021 18:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhF3Qlo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Jun 2021 12:41:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28622 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229510AbhF3Qln (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jun 2021 12:41:43 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15UG4PYh177174;
        Wed, 30 Jun 2021 12:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=WAb5S/sQmUASXz/vgCyTKpfJQAsG1dxTd1uwi/d1piw=;
 b=Iq4eXnwBKUlwsHosqFZHmNUlXeNIS/F7mbUmOA6q3wjB1TMRyVUThWtmFneggdwC0Ruz
 1OzcyJgPN+w8gfX1/dIalaXQYiQzwVmr41RpCH4b13fcJxHgei6YNB4F6bV2K9LxKv0j
 xgbY9dUS5jEPQDIj04wlElWykSDGlmO8NfxtHpMK17nkuzrt6kehTFPrdavPBms1fb31
 knA6GlLBy3ZbXCYXjnmd2Vi7dLnBZyxuvVe4J2Mkv8ZBbkftG/ET/Sk/9uclRhfcFGJc
 GMRscfGezMSghB5XwaWFLDnbDMRmrrhMKdtvrmzjgfRq+I1y7+HT2Tdf6YjqXC2R+b6+ UA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39gut0h48y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 12:39:13 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15UG4Zwt178349;
        Wed, 30 Jun 2021 12:39:12 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39gut0h484-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 12:39:12 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15UGdAAi010043;
        Wed, 30 Jun 2021 16:39:10 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 39ft8ere8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 16:39:10 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15UGd8Tg34275746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 16:39:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF898A2255;
        Wed, 30 Jun 2021 16:39:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.114.126])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 19D50A224D;
        Wed, 30 Jun 2021 16:39:05 +0000 (GMT)
Message-ID: <ade6f210f65d16605c9c17b238f65e8d781a8030.camel@linux.ibm.com>
Subject: Re: [PATCH v6 2/3] ima-evm-utils: Allow manual setting keyid from a
 cert file
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 30 Jun 2021 12:39:05 -0400
In-Reply-To: <20210626002734.ojk57twxcnfnpzxw@altlinux.org>
References: <20210511115630.795208-1-vt@altlinux.org>
         <20210511115630.795208-3-vt@altlinux.org>
         <ffac9c53bacfc5a0d16ae457289d7c224c8ef924.camel@linux.ibm.com>
         <20210626002734.ojk57twxcnfnpzxw@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Nbl3SEy6c9HK7TiW2fjvkTb2xVRivQV4
X-Proofpoint-ORIG-GUID: rsG8Xj4FJpPh026_q5t7ADEpQxIDoSHZ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-30_08:2021-06-30,2021-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106300092
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

On Sat, 2021-06-26 at 03:27 +0300, Vitaly Chikunov wrote:
> > In either case, is imaevm_params.keyid
> > suppose to be big endian byte order? 
> 
> No, it's in native order. This looked reasonable, since it could be
> presented to the user as a hex number.

My confusion must have come from the __read_keyid() comment.

+ * @keyid:     Pointer to 32-bit value in network order, can be
unaligned.

Please annotate the comment and the imaevm_params.keyid appropriately.

thanks,

Mimi

