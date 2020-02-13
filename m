Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF0815CBBC
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2020 21:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgBMULr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Feb 2020 15:11:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7416 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728040AbgBMULr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Feb 2020 15:11:47 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01DKBf5U057292;
        Thu, 13 Feb 2020 15:11:44 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y4qybcmgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 15:11:43 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01DKBgBZ057356;
        Thu, 13 Feb 2020 15:11:42 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y4qybcmdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 15:11:42 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01DJtFYn006404;
        Thu, 13 Feb 2020 20:11:31 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02dal.us.ibm.com with ESMTP id 2y5bc0h0jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 20:11:31 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01DKBUPj54395240
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 20:11:30 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D717124053;
        Thu, 13 Feb 2020 20:11:30 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7EFD6124052;
        Thu, 13 Feb 2020 20:11:30 +0000 (GMT)
Received: from [9.2.202.60] (unknown [9.2.202.60])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 13 Feb 2020 20:11:30 +0000 (GMT)
Subject: Re: [PATCH v2] ima: export the measurement list when needed
To:     david.safford@gmail.com, Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
Cc:     monty.wiseman@ge.com
References: <20200108111743.23393-1-janne.karhunen@gmail.com>
 <CAE=NcrZrbRinOAbB+k1rjhcae3nqfJ8snC_EnY8njMDioM7=vg@mail.gmail.com>
 <1580998432.5585.411.camel@linux.ibm.com>
 <40f780ffe2ddc879e5fa4443c098c0f1d331390f.camel@gmail.com>
 <1581366258.5585.891.camel@linux.ibm.com>
 <fab03a0b8cc9dc93f2d0db51071521ce82e2b96b.camel@gmail.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <f095a412-9967-416d-a4d9-d3b5799f8409@linux.ibm.com>
Date:   Thu, 13 Feb 2020 15:11:30 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <fab03a0b8cc9dc93f2d0db51071521ce82e2b96b.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_07:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130140
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/11/2020 11:10 AM, david.safford@gmail.com wrote:
> There is no reason to resend the same data for every attestation,
> nor is there any reason to store already attested measurements anywhere
> on the client. By versioning the log file names, userspace gets a
> simple way to know what has and has not been attested, and for small
> embedded devices we don't need to waste memory or filesystem space
> on the data already attested.

Yes ... no.

There isn't any reason to resend measurements that a verifier has 
already received.  In fact, the logic I coded also said "if PCR 10 
didn't change, there's no need to even ask for the measurement log".

However, don't you have to save already attested measurements for
the case where there are multiple verifiers?  A different verifier would 
have to receive all measurements.

