Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEB63CBED2
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jul 2021 23:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbhGPWCG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Jul 2021 18:02:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236935AbhGPWB7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Jul 2021 18:01:59 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16GLXkoP167426
        for <linux-integrity@vger.kernel.org>; Fri, 16 Jul 2021 17:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=eVM0sggVe4cwBb/p3OkbF9d6TT6BigiKS7T0Uw40DTw=;
 b=f6JunvJ5Cg/QWJhZ5GNlPsEC63JZ4qsTCWG0A6ZR95FjseQ9TM/OBiXCptaPiYxieQr/
 QAzYydAStiVQ7FK7plxxxi+AjyOADd4+dmnBjyFbo/IYcv0cIQzv/cBKdQtNOpCblDzw
 ETQak98hXj6ct4AMCmFDftssu3mP58G76eGZjZYRErFFHINNL5GVbwu/mpyTMwD68wGE
 eahza6J104WmSZVxHSPiMAmYjsKAtpnvZtMzaKB4RMQ4+L6veVxnI1b8xkcwWjH4dEBH
 uHEfF8hJTKOdMmRXcV5jjEuAkTGsl8ZW5Jf9JwFRlxutUlnEcVk6dOTajq7rBedeGvZ/ rA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39uhxjgmcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 16 Jul 2021 17:59:02 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16GLx0JK007862
        for <linux-integrity@vger.kernel.org>; Fri, 16 Jul 2021 21:59:00 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 39q3689j0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 16 Jul 2021 21:59:00 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16GLwvMd21299570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jul 2021 21:58:57 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 472C1AE04D;
        Fri, 16 Jul 2021 21:58:57 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A6CBAE045;
        Fri, 16 Jul 2021 21:58:56 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.55.33])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 16 Jul 2021 21:58:56 +0000 (GMT)
Message-ID: <dad1c6c6fd8900d890c737d1f1291a5c0941d819.camel@linux.ibm.com>
Subject: Re: [PATCH] evmctl: Remove left-over check S_ISDIR() for directory
 signing
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Date:   Fri, 16 Jul 2021 17:58:55 -0400
In-Reply-To: <20210716193300.135084-1-stefanb@linux.ibm.com>
References: <20210716193300.135084-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5nu1POFkmeWu6LgjbBFhStHaOSO4PmIb
X-Proofpoint-GUID: 5nu1POFkmeWu6LgjbBFhStHaOSO4PmIb
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-16_10:2021-07-16,2021-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107160136
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-07-16 at 15:33 -0400, Stefan Berger wrote:
> Since we are not signing directory entries, remove the left-over check
> with S_ISDIR().
> 
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Thanks, applied to next-integrity.

Mimi

