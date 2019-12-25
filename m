Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9491C12A891
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Dec 2019 17:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfLYQjH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Dec 2019 11:39:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbfLYQjH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Dec 2019 11:39:07 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBPGbk4x040324;
        Wed, 25 Dec 2019 11:39:05 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x1fwyfrap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Dec 2019 11:39:04 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBPGc2eh040585;
        Wed, 25 Dec 2019 11:39:04 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x1fwyfrad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Dec 2019 11:39:04 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBPGZWg3017280;
        Wed, 25 Dec 2019 16:39:03 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma05wdc.us.ibm.com with ESMTP id 2x1b16u48x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Dec 2019 16:39:03 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBPGd26e56820080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Dec 2019 16:39:02 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 471586E054;
        Wed, 25 Dec 2019 16:39:02 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D37C76E04E;
        Wed, 25 Dec 2019 16:39:01 +0000 (GMT)
Received: from [9.80.238.60] (unknown [9.80.238.60])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 25 Dec 2019 16:39:01 +0000 (GMT)
Subject: Re: forever growing ima measurement list
To:     Janne Karhunen <janne.karhunen@gmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     linux-integrity@vger.kernel.org
References: <CAE=Ncrb-kMDRgALnvXtKukSVLEw81rqxGv6+XXxg487Q_qLKGA@mail.gmail.com>
 <f48371ec-3754-05b8-3b31-da6842f9d486@linux.microsoft.com>
 <CAE=NcrZyFRkK7hQohZq5y5wANfbehJRrvs-3BeCOTg9SF=-X=g@mail.gmail.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <7683ea32-06e8-eef2-ed4f-8ace37a0f458@linux.ibm.com>
Date:   Wed, 25 Dec 2019 11:39:02 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAE=NcrZyFRkK7hQohZq5y5wANfbehJRrvs-3BeCOTg9SF=-X=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-25_05:2019-12-24,2019-12-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912250142
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/11/2019 2:26 AM, Janne Karhunen wrote:
>> I am assuming one of the reasons for keeping the measurement list in
>> memory is for better performance. If buffered file I/O is supported in
>> Linux, can that be leveraged for improved file I/O performance?
 >
> AFAIK Linux only does buffered io (with LRU) unless sync is being
> explicitly asked. Exporting the file would be a rare event, so it will
> not hopefully be a performance sensitive operation by any means.

My experience is that the 100's of msec to do a TPM quote signature
makes the rest of the attestation process negligible.

In addition, an optimized system only sends the full log once, and 
deltas thereafter.  It would be nice if there was a fast way to
skip to entry n without parsing the internals of each entry.  Perhaps
this could be added as part of the "copy to a file" enhancement.
