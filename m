Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2950144A488
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Nov 2021 03:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbhKICUb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Nov 2021 21:20:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23856 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238836AbhKICUa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Nov 2021 21:20:30 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A90m3A7021935;
        Tue, 9 Nov 2021 02:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=srivzpXQQj1XWX94GmBJogiyqRcek1t80QGSGRKBNUw=;
 b=ZC+cb4YrFGH/5N3PReXhRK5jVvJLft/lqp4ZqdFMfTs1gOiYlIXLwl9ifIws0lQavbDv
 RCaoNGkCvStvAhdjMcT/spiNs8dZp1yP2yHDFglA8+kfSr92aegrEIs45+03TuyXEZr8
 vdGrr8ePqqEbLJgpguwhsyAavsJZA9fcCl/+qjZZqRcaWvmc2L0B4fzm6Fg/v/EfXeJ1
 iSpW4rfgO5ZfHICrlhrrohyTXnvNLlB/U5TaOkgodeT+KREN69ABQCyM5P/Wcr7RvNjR
 67oLPXVPppNgtcYn2qvgFB6qF3PgZbT0/fBHYqYdVWxqvCOtpoWxWP7LuW3tFCCKT8bm /g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3c7erx1ptj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Nov 2021 02:17:39 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1A926hUr032717;
        Tue, 9 Nov 2021 02:17:39 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3c7erx1psx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Nov 2021 02:17:39 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1A92Dn0K014479;
        Tue, 9 Nov 2021 02:17:36 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3c5gyjb44r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Nov 2021 02:17:36 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1A92HYR6066168
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Nov 2021 02:17:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82E6111C050;
        Tue,  9 Nov 2021 02:17:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1CCD11C052;
        Tue,  9 Nov 2021 02:17:33 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.5.243])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Nov 2021 02:17:33 +0000 (GMT)
Message-ID: <ca8a4b45b3d7449b41b244217dddc9c91335780c.camel@linux.ibm.com>
Subject: Re: ima-evm-utils: version 1.4 released
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>
Date:   Mon, 08 Nov 2021 21:17:33 -0500
In-Reply-To: <YYmLOoa6E78G3ii2@pevik>
References: <9af9143c2c90f1ebae6cc34a7100673332cce1a1.camel@linux.ibm.com>
         <YYToG+8u/edIcc3u@pevik>
         <e7213f8c-a6f5-f73e-d88f-a264e6d231bb@linux.microsoft.com>
         <9475f96833540e0601b23b40cbc1dcbc30903ec6.camel@linux.ibm.com>
         <YYmLOoa6E78G3ii2@pevik>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y4b2A1bi6B0p-7Hv6C9hyd9PX3tWS0IY
X-Proofpoint-ORIG-GUID: dxOCfhJFMYzzBGyYvFGfRHV0TXejl9Bv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-08_07,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111090007
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On Mon, 2021-11-08 at 21:40 +0100, Petr Vorel wrote:
> Github repository is marked as primary. How about moving releases also to
> GitHub?

Done.

thanks,

Mimi

