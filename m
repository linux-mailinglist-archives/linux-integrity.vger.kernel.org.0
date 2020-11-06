Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E9E2A975C
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Nov 2020 15:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgKFOC7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Nov 2020 09:02:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727263AbgKFOC7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Nov 2020 09:02:59 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6E1Lpt076369;
        Fri, 6 Nov 2020 09:02:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=vEsnfnljgi10FY8f+eHuNuFVn88s5gBhJUyG0fD/nvM=;
 b=qC+VvwjkvSPSyUkcaxrOXwklUgAONd1oFup45bl20X7ezHL0syEMLg42fld+SAcqf2es
 s1L40QkRYW1iQ9jETB6Fxh/x/5CX7IIr7ILEnBO+hfo6gVl38BAB1cT5v+rJmizrxOo+
 6iQGFxfzrmehMvHemaW/u7b9d94l4VIVhNqIPwqI835AVfbCRKeUIwYLH6bb2Prxb9V2
 DbvJlwP9sGra4craf1+UzhsN3AzqWU0wZVKgP1GPKZrGvvDBpoREv2iKlF1JLnK8y45m
 OZYh1hl5NwtF8ZgELIFg8/4qoBAfgbFHEkuSv7shL66HJgQphNyoNziHkklwkkMi7zGt dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34m7rev8ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 09:02:48 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A6E1kOh077657;
        Fri, 6 Nov 2020 09:02:13 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34m7rev81f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 09:02:13 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A6E1qbs015211;
        Fri, 6 Nov 2020 14:01:52 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 34hm6hdtqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 14:01:51 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A6E1n8b65339700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Nov 2020 14:01:49 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4355AE04D;
        Fri,  6 Nov 2020 14:01:49 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C2B5AE045;
        Fri,  6 Nov 2020 14:01:46 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.77.67])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 Nov 2020 14:01:46 +0000 (GMT)
Message-ID: <bef97a69db37d358db21668b179fd8821430b1b4.camel@linux.ibm.com>
Subject: Re: [PATCH v5 5/7] IMA: validate supported kernel data sources
 before measurement
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Fri, 06 Nov 2020 09:01:45 -0500
In-Reply-To: <20201101222626.6111-6-tusharsu@linux.microsoft.com>
References: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
         <20201101222626.6111-6-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_04:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011060101
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

On Sun, 2020-11-01 at 14:26 -0800, Tushar Sugandhi wrote:
> Currently, IMA does not restrict random data sources from measuring
> their data using ima_measure_critical_data(). Any kernel data source can
> call the function, and it's data will get measured as long as the input
> event_data_source is part of the IMA policy - CRITICAL_DATA+data_sources.
> 
> To ensure that only data from supported sources are measured, the kernel
> subsystem name needs to be added to a compile-time list of supported
> sources (an "allowed list of components"). IMA then validates the input
> parameter - "event_data_source" passed to ima_measure_critical_data()
> against this allowed list at run-time.
> 
> This compile-time list must be updated when kernel subsystems are
> updated to measure their data using IMA.
> 
> Provide an infrastructure for kernel data sources to be added to
> IMA's supported data sources list at compile-time. Update
> ima_measure_critical_data() to validate, at run-time, that the data
> source is supported before measuring the data coming from that source.

For those interested in limiting which critical data to measure, the
"data sources" IMA policy rule option already does that.   Why is this
needed?

thanks,

Mimi

