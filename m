Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACC239778D
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Jun 2021 18:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhFAQM5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Jun 2021 12:12:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55200 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232490AbhFAQM4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Jun 2021 12:12:56 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 151G3HlT191311;
        Tue, 1 Jun 2021 12:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=wpJ9EjHra92DkVCSdbGlKcp7UVGQDXqqS5WOBCtsgUs=;
 b=Gf+wRthh7CJTKDBVyWhx8sAI9qzF/G28r4zBbjfo6d/3OHuFHUF+ucCtzHvXCK+A+n8m
 fuwuS2hOvLdEhebP1SjmiGY8/VyYT4k+QWNRrGoXlXFFJeaEYHiwe3zfGd0Y+fu9VkTk
 fL9dgPhbTkPTXH2btAK0BgtQM74JMtdSk2Ym91hT5rfaPaccnSq8nc5PJjE/6j5rF8Dm
 kOQNE9riXZbTi8UPOeP8+0RdWICdCT0lfDnOgvCS0ZnhEbA5slAYrhr0og84ApF3rHSs
 3NQhGSCeVriKiIhkJ1EJRUot2gYdrcvim/OdKmY2GkVOZALD9O6dleox5QO+18waUyC9 bA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38wr2e88e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 12:11:02 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 151G2NNN011090;
        Tue, 1 Jun 2021 16:11:00 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 38ud889u6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 16:11:00 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 151GAw1e27197936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Jun 2021 16:10:58 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5E1E4C05C;
        Tue,  1 Jun 2021 16:10:57 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F9364C04A;
        Tue,  1 Jun 2021 16:10:56 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.90.147])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Jun 2021 16:10:56 +0000 (GMT)
Message-ID: <60a8dd3dddfa469e08c673af30ed08dca3baec1a.camel@linux.ibm.com>
Subject: Re: [RESEND][PATCH v2 5/7] ima: Define new template fields
 xattrnames, xattrlengths and xattrvalues
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, mjg59@srcf.ucam.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Date:   Tue, 01 Jun 2021 12:10:54 -0400
In-Reply-To: <20210601082338.908390-1-roberto.sassu@huawei.com>
References: <20210528073812.407936-6-roberto.sassu@huawei.com>
         <20210601082338.908390-1-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 58s6sedDJ8_u2SBkqZDALBJpUp3QFeL-
X-Proofpoint-ORIG-GUID: 58s6sedDJ8_u2SBkqZDALBJpUp3QFeL-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-01_08:2021-06-01,2021-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0
 mlxscore=0 clxscore=1015 spamscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106010109
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto,

On Tue, 2021-06-01 at 10:23 +0200, Roberto Sassu wrote:
> This patch defines the new template fields xattrnames, xattrlengths and
> xattrvalues, which contain respectively a list of xattr names (strings,
> separated by |), lengths (u32, hex) and values (hex). If an xattr is not
> present, the name and length are not displayed in the measurement list.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Thank you for giving credit to the "kernel test robot".   For a bug fix
patch the above "Reported-by" tag would be appropriate, but for an
existing patch it needs to be qualified.  I've modified it to:

Reported-by: kernel test robot <lkp@intel.com> [Missing prototype def]

thanks,

Mimi

