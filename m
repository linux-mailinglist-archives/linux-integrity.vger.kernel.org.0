Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA7A1520C9
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jun 2019 04:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbfFYC40 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Jun 2019 22:56:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26148 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730451AbfFYC40 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Jun 2019 22:56:26 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5P2lFHw071639
        for <linux-integrity@vger.kernel.org>; Mon, 24 Jun 2019 22:56:25 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tbagthhp4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 24 Jun 2019 22:56:24 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 25 Jun 2019 03:56:22 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Jun 2019 03:56:20 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5P2uJZB54263980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 02:56:19 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 856D3A404D;
        Tue, 25 Jun 2019 02:56:19 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD50CA4040;
        Tue, 25 Jun 2019 02:56:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.18])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jun 2019 02:56:18 +0000 (GMT)
Subject: Re: [PATCH v7 00/11] ima-evm-utils: Convert v2 signatures from RSA
 to EVP_PKEY API
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Mon, 24 Jun 2019 22:56:08 -0400
In-Reply-To: <20190624201156.xrd6lyhrbnpbo2uz@altlinux.org>
References: <20190623090027.11852-1-vt@altlinux.org>
         <1561387352.4340.20.camel@linux.ibm.com>
         <20190624161638.xz6ebfvxzilh2gew@altlinux.org>
         <1561403393.4340.58.camel@linux.ibm.com>
         <20190624192349.gdp2xbe5c6etaw6v@altlinux.org>
         <1561405647.4340.63.camel@linux.ibm.com>
         <20190624201156.xrd6lyhrbnpbo2uz@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19062502-0012-0000-0000-0000032C166B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062502-0013-0000-0000-0000216549B7
Message-Id: <1561431368.4340.106.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250021
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-06-24 at 23:11 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Mon, Jun 24, 2019 at 03:47:27PM -0400, Mimi Zohar wrote:
> > On Mon, 2019-06-24 at 22:23 +0300, Vitaly Chikunov wrote:
> > > 
> > > > > With and without this change, the sha family is working properly, but
> > > > > with this patch set, I'm now seeing "sign_hash_v2: signing failed:
> > > > > (invalid digest)" for gost/streebog.  Previously it worked.
> > > 
> > > If it worked before this is strange. It should not. What patchset
> > > version it was?
> > 
> > No, I'm saying that I built both openssl and the gost engine a while
> > ago.  There's been some gost engine updates since then, which are
> > dependent on a newer version of openssl.  So I'll need to rebuild both
> > openssl and the gost engine in order to re-test.
> 
> Hm. I don't see a difference in signing code.
> 
> Only the difference is there was no `log_err("sign_hash_v2: signing
> failed: (%s)\n", ...)` about singing failure, because, I thought, the
> caller would report it anyway, because of `return -1`.

Thanks, Vitaly, for all your help.  It's now working properly.

Mimi

