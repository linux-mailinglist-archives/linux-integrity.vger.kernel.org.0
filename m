Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C67345E73
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Mar 2021 13:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhCWMrD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Mar 2021 08:47:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231308AbhCWMqz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Mar 2021 08:46:55 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12NCYxZ1122018;
        Tue, 23 Mar 2021 08:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=VhNk5xhD7IVz5iFotDFVfr6cD7Ctc8AZW/Pu54Zphaw=;
 b=pDBzdxgdnNUfRA7Duwm0eSoRCEyzjHAxBTrVpL7pfD+QY+U0dlraiE4eq2APk1cEQrYE
 Qvk9yZI2qAJuWXgB3NmJL8r40nUEa3O+N9EG1OaVwIw9E/O3yfUpw/DnhL86JkXDQeW9
 kZ+MXRGLFVYYItOSe+bnv3K6GCFYL+/A0BmxaCJY4byZh21156PRwgOvbqp41iqSWI7K
 u5an6j4jkffxFVXu3U/oydFZh+J3fds3VFTLUu3mYVeYBffoHDZBIp2Q/3+lt9X3KHvR
 hI8Gs4AAljPkCMu24GkjDqQdIhusO0u6DQxKzzUnfmgysBH6sOZb0+oUF+7cAOKrtdtt jA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37eb1qec9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 08:46:52 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12NCZBXq123844;
        Tue, 23 Mar 2021 08:46:51 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37eb1qec94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 08:46:51 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12NCRIdM018095;
        Tue, 23 Mar 2021 12:46:49 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 37d9by9r85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 12:46:49 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12NCkl2w41877772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 12:46:47 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A3675204F;
        Tue, 23 Mar 2021 12:46:47 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.41.170])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5B39B5204E;
        Tue, 23 Mar 2021 12:46:45 +0000 (GMT)
Message-ID: <963ca511cad72412686c5fd7d9121f85509f8659.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Fix function name error in comment.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jiele Zhao <unclexiaole@gmail.com>, dmitry.kasatkin@gmail.com,
        serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Tue, 23 Mar 2021 08:46:44 -0400
In-Reply-To: <20210323091905.317885-1-unclexiaole@gmail.com>
References: <20210323091905.317885-1-unclexiaole@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-23_06:2021-03-22,2021-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103230092
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jiele,

On Tue, 2021-03-23 at 09:19 +0000, Jiele Zhao wrote:
> Function "ima_file_check" is written as "ima_path_check" in
> the comment. Fix this error to prevent misunderstanding.
> 
> Signed-off-by: Jiele Zhao <unclexiaole@gmail.com>

The original function name was ima_path_check().  The policy parsing
still supports PATH_CHECK.   Commit 9bbb6cad0173 ("ima: rename
ima_path_check to ima_file_check") renamed the function to
ima_file_check(), but missed modifying the function name in the
comment.

Please update this patch description accordingly and add the "Fixes"
tag.

thanks,

Mimi

