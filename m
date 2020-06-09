Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FC21F4266
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jun 2020 19:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgFIReK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Jun 2020 13:34:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51748 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726848AbgFIReJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Jun 2020 13:34:09 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 059HCGDP073608;
        Tue, 9 Jun 2020 13:34:06 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31jemaghff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 13:34:05 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 059HNvaN109837;
        Tue, 9 Jun 2020 13:34:05 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31jemaghey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 13:34:05 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 059HUKOh013946;
        Tue, 9 Jun 2020 17:34:03 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 31g2s7tk3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 17:34:03 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 059HY1Rf61472978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Jun 2020 17:34:01 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21F9442042;
        Tue,  9 Jun 2020 17:34:01 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C1AA42045;
        Tue,  9 Jun 2020 17:34:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.146.136])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Jun 2020 17:34:00 +0000 (GMT)
Message-ID: <1591724039.5567.33.camel@linux.ibm.com>
Subject: Re: [PATCH v3] IMA: Add audit log for failure conditions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Richard Guy Briggs <rgb@redhat.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Steve Grubb <sgrubb@redhat.com>, linux-integrity@vger.kernel.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Date:   Tue, 09 Jun 2020 13:33:59 -0400
In-Reply-To: <20200609171555.itbllvtgjdanbbk7@madcap2.tricolour.ca>
References: <20200608215343.4491-1-nramas@linux.microsoft.com>
         <27448076.Og45N0Lxmj@x2>
         <ada45440-aefd-a4b2-2a3b-c012872e86cb@linux.microsoft.com>
         <3776526.Vj75JV9fuy@x2>
         <518a51b7-6c8d-f55f-c73a-b15abae8e0af@linux.microsoft.com>
         <20200609171555.itbllvtgjdanbbk7@madcap2.tricolour.ca>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-09_10:2020-06-09,2020-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 cotscore=-2147483648
 bulkscore=0 mlxscore=0 clxscore=1015 suspectscore=0 adultscore=0
 phishscore=0 mlxlogscore=854 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006090130
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Richard,

On Tue, 2020-06-09 at 13:15 -0400, Richard Guy Briggs wrote:
> On 2020-06-09 10:00, Lakshmi Ramasubramanian wrote:

> If it is added, it should be appended to the end of the record since it
> is an existing record format, then in the case of res=1, errno= should
> still be present (not swing in and out) and just contain zero.  (Or
> another value if there is a non-fatal warning?)

Thank you for the clarification.

Mimi
