Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859843B49D7
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jun 2021 22:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhFYUo7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Jun 2021 16:44:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44520 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229573AbhFYUo7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Jun 2021 16:44:59 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15PKXp4G106850
        for <linux-integrity@vger.kernel.org>; Fri, 25 Jun 2021 16:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=CPEPN78Qon9CbBNpznOmiaJmYFPEIHsxBWPE5u2btEg=;
 b=FQmHq/IMF7uMDbNRXB7SC0VR8I06Wb3WEALFIQiOJCPHAEsIvwZIpksAjEcAaknCNiac
 nZsq5r7C+lEoNGXq6xKJKLYGvbboIYCDdbBj/o2wHDQRbyTBTRNNT8ZA8mG5H2bY1xPK
 c13sZOX69o8wsFTvAW18DxRDgmi0R/G/CTvG9NyKY/f7gWcHOFhazN6taUyp4ZKPd8EH
 Wer2TMPxelRnV8mJab7J0aLIllKYAB/x9hmCjC2gBRXdT6gcHNio/jbL+5QM26biAa6u
 Euj3mthMzP3+xE2Zhm3wex0QcAkcJJJUMNg1EL/4mSXmVfZ2rCzlXZi3CAFn2HiI9ths jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39dp2jrmp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 25 Jun 2021 16:42:37 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15PKYdHs112462
        for <linux-integrity@vger.kernel.org>; Fri, 25 Jun 2021 16:42:37 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39dp2jrmkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Jun 2021 16:42:37 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15PKgZl7019001;
        Fri, 25 Jun 2021 20:42:35 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3998789sp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Jun 2021 20:42:35 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15PKgVPU34406722
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 20:42:32 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6E795204F;
        Fri, 25 Jun 2021 20:42:31 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.9.226])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id EB0D052051;
        Fri, 25 Jun 2021 20:42:30 +0000 (GMT)
Message-ID: <78ef36d6a93ab7b6ae2382ba2c24eee9bc36b22d.camel@linux.ibm.com>
Subject: Re: [PATCH 0/6] ima-evm-utils: Some cleanups and bugfixes
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     dmitry.kasatkin@gmail.com
Date:   Fri, 25 Jun 2021 16:42:30 -0400
In-Reply-To: <20210419150151.236409-1-stefanb@linux.ibm.com>
References: <20210419150151.236409-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ebQk3iou6mIvv7Go-o44I9FqGNUvgb4-
X-Proofpoint-GUID: DfheFuyv1j9YNgfTkDIR9e8Jmt9PRIHK
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-25_07:2021-06-25,2021-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106250126
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

On Mon, 2021-04-19 at 11:01 -0400, Stefan Berger wrote:
> This PR contains some cleanups and bugfixes for libimaevm of ima-evm-utils.

In the future, for ima-evm-utils patches, please prefix all patches
with "ima-evm-utils", not just the cover letter (e.g. --subject-
prefix="PATCH ima-evm-utils").

This patch set is now in next-testing.

thanks,

Mimi

