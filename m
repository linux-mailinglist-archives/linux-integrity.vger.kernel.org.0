Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4FC12090
	for <lists+linux-integrity@lfdr.de>; Thu,  2 May 2019 18:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfEBQwh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 May 2019 12:52:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54440 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726138AbfEBQwd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 May 2019 12:52:33 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x42GgCCn006245
        for <linux-integrity@vger.kernel.org>; Thu, 2 May 2019 12:52:32 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s845hgr23-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 02 May 2019 12:52:32 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 2 May 2019 17:52:30 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 May 2019 17:52:26 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x42GqQXT38142030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 May 2019 16:52:26 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E44DC5205A;
        Thu,  2 May 2019 16:52:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.95.175])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 07E365204E;
        Thu,  2 May 2019 16:52:24 +0000 (GMT)
Subject: Re: [PATCH v3 2/4] add the buffer to the xattr
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Prakhar Srivastava <prsriva02@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-secuirty-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, vgoyal@redhat.com, nayna@linux.ibm.com
Date:   Thu, 02 May 2019 12:52:13 -0400
In-Reply-To: <20190429214743.4625-3-prsriva02@gmail.com>
References: <20190429214743.4625-1-prsriva02@gmail.com>
         <20190429214743.4625-3-prsriva02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19050216-0028-0000-0000-00000369A3AC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050216-0029-0000-0000-000024290FDF
Message-Id: <1556815933.4134.77.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-02_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905020109
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-04-29 at 14:47 -0700, Prakhar Srivastava wrote:
> From: Prakhar Srivastava <prsriva02@gmail.com>
> 
> add the buffer to the xattr for a buffer case

Please write full patch descriptions, here and in the other patches,
explaining the current status with the motivation for the change.

> 
> Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
> ---

< snip >
>  
> @@ -630,17 +651,23 @@ static int process_buffer_measurement(const void *buff, int size,
>  	if (ret < 0)
>  		goto err_out;
>  
> -	ret = ima_store_template(entry, violation, NULL,
> +	if (action & IMA_MEASURE)
> +		ret = ima_store_template(entry, violation, NULL,
>  					buff, pcr);

Although scripts/Lindent has its problems, it does a good job with
code formatting.  There's no reason here for the line breakage.

Mimi

