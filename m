Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A892E12997D
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Dec 2019 18:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfLWRjW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Dec 2019 12:39:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20118 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726787AbfLWRjW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Dec 2019 12:39:22 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBNHbA3c133799
        for <linux-integrity@vger.kernel.org>; Mon, 23 Dec 2019 12:39:21 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x21hku416-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 23 Dec 2019 12:39:20 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 23 Dec 2019 17:39:18 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Dec 2019 17:39:13 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBNHdDqT55902236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Dec 2019 17:39:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F069E5204F;
        Mon, 23 Dec 2019 17:39:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.238.12])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id F253852051;
        Mon, 23 Dec 2019 17:39:11 +0000 (GMT)
Subject: Re: [PATCH] ima: add the ability to query ima for the hash of a
 given file.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Florent Revest <revest@chromium.org>,
        linux-integrity@vger.kernel.org
Cc:     kpsingh@chromium.org, mjg59@google.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Florent Revest <revest@google.com>
Date:   Mon, 23 Dec 2019 12:39:11 -0500
In-Reply-To: <8f4d9c4e-735d-8ba9-b84a-4f341030e0cf@linux.microsoft.com>
References: <20191220163136.25010-1-revest@chromium.org>
         <8f4d9c4e-735d-8ba9-b84a-4f341030e0cf@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19122317-0020-0000-0000-0000039AF936
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19122317-0021-0000-0000-000021F22FF1
Message-Id: <1577122751.5241.144.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-23_07:2019-12-23,2019-12-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912230150
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-12-20 at 08:48 -0800, Lakshmi Ramasubramanian wrote:
> On 12/20/2019 8:31 AM, Florent Revest wrote:
> 
> >   
> > +/**
> > + * ima_file_hash - return the stored measurement if a file has been hashed.
> > + * @file: pointer to the file
> > + * @buf: buffer in which to store the hash
> > + * @buf_size: length of the buffer
> > + *
> > + * On success, output the hash into buf and return the hash algorithm (as
> > + * defined in the enum hash_algo).
> 
> > + * If the hash is larger than buf, then only size bytes will be copied. It
> > + * generally just makes sense to pass a buffer capable of holding the largest
> > + * possible hash: IMA_MAX_DIGEST_SIZE
> 
> If the given buffer is smaller than the hash length, wouldn't it be 
> better to return the required size and a status indicating the buffer is 
> not enough. The caller can then call back with the required buffer.
> 
> If the hash is truncated the caller may not know if the hash is partial 
> or not.

Based on the hash algorithm, the caller would know if the buffer
provided was too small and was truncated.

> 
> > + *
> > + * If IMA is disabled or if no measurement is available, return -EOPNOTSUPP.
> > + * If the parameters are incorrect, return -EINVAL.
> > + */
> > +int ima_file_hash(struct file *file, char *buf, size_t buf_size)
> > +{
> > +	struct inode *inode;
> > +	struct integrity_iint_cache *iint;
> > +	size_t copied_size;
> > +
> > +	if (!file || !buf)
> > +		return -EINVAL;
> > +

Other kernel functions provide a means of determining the needed
buffer size by passing a NULL field.  Instead of failing here, if buf
is NULL, how about returning the hash algorithm?

Mimi

> > +	if (!ima_policy_flag)
> > +		return -EOPNOTSUPP;
> > +

