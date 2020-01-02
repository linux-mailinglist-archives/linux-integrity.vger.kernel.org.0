Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2D012EAD7
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Jan 2020 21:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgABUZd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Jan 2020 15:25:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725783AbgABUZd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Jan 2020 15:25:33 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 002KI6vH068003
        for <linux-integrity@vger.kernel.org>; Thu, 2 Jan 2020 15:25:32 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x63k0p2w0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 02 Jan 2020 15:25:32 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 2 Jan 2020 20:25:29 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 Jan 2020 20:25:28 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 002KPQUh30408718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Jan 2020 20:25:26 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BC114C044;
        Thu,  2 Jan 2020 20:25:26 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CECD34C04A;
        Thu,  2 Jan 2020 20:25:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.148.97])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  2 Jan 2020 20:25:25 +0000 (GMT)
Subject: Re: Spec needed for ima-modsig template
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ken Goldman <kgold@linux.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Ken Goldman <kgoldman@us.ibm.com>
Date:   Thu, 02 Jan 2020 15:25:25 -0500
In-Reply-To: <e2e2863e-9908-5156-8aca-32f8e583f0e3@linux.ibm.com>
References: <e2e2863e-9908-5156-8aca-32f8e583f0e3@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20010220-0028-0000-0000-000003CDBBED
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010220-0029-0000-0000-00002491C25D
Message-Id: <1577996725.5874.114.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-02_06:2020-01-02,2020-01-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=585
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001020163
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-01-02 at 15:10 -0500, Ken Goldman wrote:
> I'm trying to document the ima-modsig template and then write aparser. 
> Can anyone help me complete it?
> 
> 1 - What the implementation does today is interesting.  Even betterwould 
> be what the implementation is permitted to do so that theparser will 
> handle future changes.
> 
> 2 - My understanding so far:
> 
>      ima-modsig        is        d-ng | n-ng | sig | d-modsig |modsig
> 
>      where (both have a prepended uint32_t length)
> 
>      d-modsig            is    d-ng, filedata hash, omitting the 
> appended modsig signature
>      modsig                is     pkcs7DER, appended signature
> 
> My immediate issue is that the d-modsig should be a length + 
> hashalgorithm + file data hash.  However, the length in my sample log 
> issometimes zero, which I did not expect.
> 
> I.e., it it legal for an ima-modsig template to contain an emptyd-modsig 
> item?
> 
> Can the modsig item also be empty?

Like the "sig" field in the "ima-sig" template, both the "d-modsig"
and "modsig" fields in the "ima-modsig" template may be empty.

Mimi

