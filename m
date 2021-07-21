Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD783D06A2
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Jul 2021 04:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhGUBcA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Jul 2021 21:32:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38386 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230514AbhGUBbw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Jul 2021 21:31:52 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16L24oDg166484;
        Tue, 20 Jul 2021 22:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=DLA+4vJu2NlMTDPO7BjLz+9YiYRGdEgiUlTZTgykOQA=;
 b=PHLJjE7C2ZOi9vs++OvbfVIeG4LRNCW33MgwY6zjgL2uXUhi5eIm2NHwxXWNHwEzRHkb
 8NnfN7gGm0k5CWauaCP+Yrd2FC0/AHKlYq31HcgK9mpKH/327V9zX4MZ1k/hXJu4ApTf
 KX8jsHAHAnCh0Khnax7wk/debKg5Mi6SWkN+5cbpBACku3cb7Rt7udvci5AsMg40BSDt
 y0OG8nfVPLYlO8MAFLNa43c9ufHqHAMPFNX0Rsc5RofI2wrUgJ7Rq08ZhPEHTVCmo0Ft
 D32OyujiY+DAIVACff3abuWwGi3FF6vj8u3LB8mNwzDonmwJE84iNcmvxihkXSBswiLB kA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39x9qt90wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jul 2021 22:12:23 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16L24rQn166933;
        Tue, 20 Jul 2021 22:12:23 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39x9qt90wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jul 2021 22:12:23 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16L26nwS030998;
        Wed, 21 Jul 2021 02:12:21 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 39upu89m1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 02:12:21 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16L29rnT33292672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 02:09:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 201A642047;
        Wed, 21 Jul 2021 02:12:19 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B2144203F;
        Wed, 21 Jul 2021 02:12:17 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.1.44])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 21 Jul 2021 02:12:17 +0000 (GMT)
Message-ID: <713d22788b678c612c5b18edfb8cf849af61ace5.camel@linux.ibm.com>
Subject: Re: [PATCH 1/7] dm: measure data on table load
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com
Cc:     linux-integrity@vger.kernel.org, nramas@linux.microsoft.com
Date:   Tue, 20 Jul 2021 22:12:16 -0400
In-Reply-To: <20210713004904.8808-2-tusharsu@linux.microsoft.com>
References: <20210713004904.8808-1-tusharsu@linux.microsoft.com>
         <20210713004904.8808-2-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 79jdo0nO-QNTfHHtwpfqzOtWJRvrHkbh
X-Proofpoint-GUID: a9h3mcYU3RRcY7Fgn9Iyp6s8axWn3N5-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-20_15:2021-07-19,2021-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 adultscore=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107210010
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar, Mike, 

On Mon, 2021-07-12 at 17:48 -0700, Tushar Sugandhi wrote:
> +struct dm_ima_device_table_metadata {
> +       /*
> +        * Contains data specific to the device which is common across
> +        * all the targets in the table.e.g. name, uuid, major, minor etc.
> +        * The values are stored in comma separated list of key1=val1,key2=val2; pairs
> +        * delimited by a semicolon at the end of the list.
> +        */
> +       char *device_metadata;
> +       unsigned int device_metadata_len;
> +       unsigned int num_targets;
> +
> +       /*
> +        * Contains the sha256 hashs of the IMA measurements of the
> +        * target attributes key-value pairs from the active/inactive tables.
> +        */

From past experience hard coding the hash algorithm is really not a
good idea.

Mimi

> +       char *hash;
> +       unsigned int hash_len;
> +
> +};


