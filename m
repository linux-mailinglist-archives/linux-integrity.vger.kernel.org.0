Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F86209E9B
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 14:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404518AbgFYMlc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 08:41:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60886 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404610AbgFYMlb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 08:41:31 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05PCXTCQ004196;
        Thu, 25 Jun 2020 08:41:21 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31ux00p3fh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 08:41:21 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05PCXsQP006368;
        Thu, 25 Jun 2020 08:41:20 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31ux00p3ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 08:41:20 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05PCZd5N023602;
        Thu, 25 Jun 2020 12:41:20 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04dal.us.ibm.com with ESMTP id 31uurq6xhp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 12:41:20 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05PCfJbw52494680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jun 2020 12:41:19 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3458C112061;
        Thu, 25 Jun 2020 12:41:19 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24CD5112063;
        Thu, 25 Jun 2020 12:41:19 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 25 Jun 2020 12:41:19 +0000 (GMT)
Subject: Re: [PATCH v2] tpm: tpm2-space: Resize session and context buffers
 dynamically
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Alexey Klimov <aklimov@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20200625043819.376693-1-jarkko.sakkinen@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <8d19d5e2-91bc-09ad-6b94-d51a7aad6376@linux.ibm.com>
Date:   Thu, 25 Jun 2020 08:41:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200625043819.376693-1-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-25_05:2020-06-25,2020-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 cotscore=-2147483648 priorityscore=1501 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 malwarescore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006250078
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/25/20 12:38 AM, Jarkko Sakkinen wrote:
> Re-allocate context and session buffers when needed. Scale them in page
> increments so that the reallocation is only seldomly required, and thus
> causes minimal stress to the system. Add a static maximum limit of four
> pages for buffer sizes.
>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>


You don't want to try a fixes tag? None of the previous versions of this 
code will work with newer versions of the TPM 2 then...


    Stefan


