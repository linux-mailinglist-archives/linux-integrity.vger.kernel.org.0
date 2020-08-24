Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F37B24FE7A
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Aug 2020 15:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgHXNDI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Aug 2020 09:03:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727774AbgHXNDH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Aug 2020 09:03:07 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07OD2ZHx095086;
        Mon, 24 Aug 2020 09:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=W2mh9+xogrvrMRCw5xMAGNdHiDT6mqWyQbS8cOp1XkY=;
 b=Wi+Zu+BGQgMhUNJ/D+bcMUocxMnfFto0qT/BfJ4B9r+5BjPRnKpo05FD+41FlZARhkT/
 uWhb45mUpPDxDdeRxFCLUgDMWNybV4NWiae+KNN08MFwTcNVNj9mrAXULGZsPs74dxvA
 6QYpAW9N1iLZfaxpo36GQnJvTP9qPUTNl4VdSCsFTRajaTGk68dyy2GDMeY0oi8xpqW0
 g0+C1mq/Y15eL9v+Ioaj+LD7QgdulVBvH5Yc6i2Br0AjxPxTuRtZN5sOKxBuhJeM0/DO
 8vN87tz6T0Dix82uX/Ypo/azNqjYIh70nyIMxYlnMp8o9rjrITVoYJwD76OfSy3Lk1SH Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 334b5c5ndh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 09:03:03 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07OD2tAJ096823;
        Mon, 24 Aug 2020 09:02:57 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 334b5c5mve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 09:02:57 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07OCwAA6009870;
        Mon, 24 Aug 2020 13:02:19 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 332uwesef0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 13:02:19 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07OD2HR459900208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Aug 2020 13:02:17 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 016F3A4068;
        Mon, 24 Aug 2020 13:02:17 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94C76A4062;
        Mon, 24 Aug 2020 13:02:15 +0000 (GMT)
Received: from sig-9-65-254-31.ibm.com (unknown [9.65.254.31])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 24 Aug 2020 13:02:15 +0000 (GMT)
Message-ID: <681d6bd21410152c0488615b634f4b29140a3974.camel@linux.ibm.com>
Subject: Re: [PATCH 09/11] ima: Don't remove security.ima if file must not
 be appraised
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, mjg59@google.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date:   Mon, 24 Aug 2020 09:02:14 -0400
In-Reply-To: <20200618160458.1579-9-roberto.sassu@huawei.com>
References: <20200618160329.1263-2-roberto.sassu@huawei.com>
         <20200618160458.1579-9-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_11:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 impostorscore=0 suspectscore=3 clxscore=1015
 phishscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=772
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240099
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-06-18 at 18:04 +0200, Roberto Sassu wrote:
> Files might come from a remote source and might have xattrs, including
> security.ima. It should not be IMA task to decide whether security.ima
> should be kept or not. This patch removes the removexattr() system
> call in ima_inode_post_setattr().
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Yes, this has been previously discussed.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

