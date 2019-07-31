Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0A97CFEA
	for <lists+linux-integrity@lfdr.de>; Wed, 31 Jul 2019 23:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfGaVPD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 31 Jul 2019 17:15:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbfGaVPD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 31 Jul 2019 17:15:03 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6VL7lAt128742
        for <linux-integrity@vger.kernel.org>; Wed, 31 Jul 2019 17:15:02 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u3j3n1g33-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 31 Jul 2019 17:15:02 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 31 Jul 2019 22:15:00 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 31 Jul 2019 22:14:57 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6VLEusF53870612
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 21:14:56 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F4615204F;
        Wed, 31 Jul 2019 21:14:56 +0000 (GMT)
Received: from dhcp-9-31-103-88.watson.ibm.com (unknown [9.31.103.88])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 917BF52050;
        Wed, 31 Jul 2019 21:14:55 +0000 (GMT)
Subject: Re: [PATCH v6] ima-evm-utils: Add some tests for evmctl
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 31 Jul 2019 17:14:55 -0400
In-Reply-To: <20190731163548.9934-1-vt@altlinux.org>
References: <20190731163548.9934-1-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19073121-4275-0000-0000-0000035286BD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19073121-4276-0000-0000-00003863778A
Message-Id: <1564607695.4154.8.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=939 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907310212
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-07-31 at 19:35 +0300, Vitaly Chikunov wrote:
> Run `make check' to execute the tests.
> Currently only ima_hash, (evm) sign, (evm) verify, ima_sign, and
> ima_verify are tested.
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
> Changelog since v5:
> - Fix tests if gost-engine is not present. Thx to Mimi Zohar for testing on
>   Xenial.
> 
> Changelog since v4:
> - Fix bugs found by Mimi Zohar:
>  - Fix typos in variable names
>  - Fix `-out -' in asn1parse for openssl 1.0.x

Thanks, no errors now.

Mimi

