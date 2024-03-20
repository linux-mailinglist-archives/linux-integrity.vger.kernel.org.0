Return-Path: <linux-integrity+bounces-1814-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F20881178
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Mar 2024 13:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B5B1C22BED
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Mar 2024 12:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3600B3FB82;
	Wed, 20 Mar 2024 12:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m8QJ+Hsb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715A13FBAF
	for <linux-integrity@vger.kernel.org>; Wed, 20 Mar 2024 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710936450; cv=none; b=HPBKd1tJhm+d2NuS9c1Ij1GfUOMefXO6crlbQmfXq8k58qrBww1pSYqOD2caZloK0aZKslTpOUA1G9DE27we/c7sKFXGBCdRwZywzFpAShjpD3nHKHdfNpwcNfD7R+QPhDPq8QLMiZuSbnDoyI0Q/edepwoSrIpnTXCmIsbdNL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710936450; c=relaxed/simple;
	bh=Khz7txyOG2yC3ms7Ybv9bNvsDJqRdqVjCIq2go5Q3Kw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=UcVySGqxf2HsU15bl2Tzy79CFaGxYPZB+J7byUdCmKz1KelCPYn12GFFsHb1ynOqwA8qTesbfbYJMRzYXq8/Gaz8UhgyVmX87Nau1O6xsPpfII3bOOhykdTmMsFz6Qxcj1V0QjJG1orBqi5w8rJ3iMJZLJD8MRjMDTgRTcQsejw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m8QJ+Hsb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42KBnbAX017889;
	Wed, 20 Mar 2024 12:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=UhrnHiHAUA3IAuufRfp1jH0X67rR46uTn8lNYwN4BpY=;
 b=m8QJ+HsbQUNdJc3/B23WpxGkyu9/Np92euAUS6FzRTpLGZdEZFcSIq4d2y1nk4poThAW
 VcaYkowQDaGLZ9gPN3JOMDALwi/uP/CKBI7x+hI2ZTol4XM7c36RDvxPeCW0CXY/58oX
 k5CpOcXFMzl+PFl0d/7da2IEVvFE9wQnrRheRHcduFSBi4/QgXCZ5L30T8aN6j9eisGV
 ddJdV98YXFCA3AUjQV/u74lYn9SwlzsFLEZsPfNsVKeD8GpkNLG0J64cDcu68eZlFSBp
 kp2MPqyRUxQWWQ+cO9JMdVwdCS4TiOuFCHkdeVtT2ax2E07rLoqOnDYBoWJBvVR7/Bsy Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyxbr854p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 12:07:17 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42KC70KE015731;
	Wed, 20 Mar 2024 12:07:16 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyxbr854n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 12:07:16 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42KAsT5D017203;
	Wed, 20 Mar 2024 12:07:16 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwnrtec1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 12:07:15 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42KC7Dlo15598288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 12:07:15 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 367C658066;
	Wed, 20 Mar 2024 12:07:13 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FE9D5806E;
	Wed, 20 Mar 2024 12:07:12 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.14.104])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Mar 2024 12:07:12 +0000 (GMT)
Message-ID: <eb70d9dbb54da5606eda1ecb8a87d653d801f441.camel@linux.ibm.com>
Subject: Re: [PATCH v4] ima: add crypto agility support for template-hash
 algorithm
From: Mimi Zohar <zohar@linux.ibm.com>
To: Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org,
        dmitry.kasatkin@gmail.com
Cc: roberto.sassu@huawei.com, Silvia Sisinni <silvia.sisinni@polito.it>
Date: Wed, 20 Mar 2024 08:07:12 -0400
In-Reply-To: <f2ed3e2a-9052-4a95-b31f-85047a01d1dd@polito.it>
References: <20240308104953.743847-1-enrico.bravi@polito.it>
	 <18e212c7d947e8a39297fd84e1765d2bc0e82140.camel@linux.ibm.com>
	 <f2ed3e2a-9052-4a95-b31f-85047a01d1dd@polito.it>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NgytyfgG2vnrJGrPV3Zodh_vWHYRQWYa
X-Proofpoint-GUID: _mhVSSTKtcrWaRYHOVs4hb_K6CwcvH-h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200096


> > > diff --git a/security/integrity/ima/ima_fs.c
> > > b/security/integrity/ima/ima_fs.c
> > > index cd1683dad3bf..475ab368e32f 100644
> > > --- a/security/integrity/ima/ima_fs.c
> > > +++ b/security/integrity/ima/ima_fs.c
> > > @@ -116,9 +116,13 @@ void ima_putc(struct seq_file *m, void *data, int
> > > datalen)
> > >  		seq_putc(m, *(char *)data++);
> > >  }
> > >  
> > > +static struct dentry **ima_ascii_measurements_files;
> > > +static struct dentry **ima_binary_measurements_files;
> > 
> > The variable naming isn't quite right.  It's defined as a 'struct dentry',
> > but
> > the name is '*_files'.  Why not just name the variables 'ima_{ascii, binary}
> > _measurements'?
> 
> Hi Mimi,

Hi Enrico,

> thank you for pointing that out. What do you think of naming them 'ima_{ascii,
> binary}_securityfs_measurement_lists', to have also coherence with the names
> of
> the new functions defined.

As these are static variables, prefixing them with 'ima_' isn't necessary. 
Either way is fine.

> > > +static void remove_measurements_list_files(struct dentry **files)
> > 
> > And remove '_files' from the function name.  Perhaps rename it
> > remove_measurement_lists or remove_securityfs_measurement_lists.
> > 
> > > +{
> > > +	int i;
> > > +
> > > +	if (files) {
> > > +		for (i = 0; i < ima_measurements_files_count; i++)
> > > +			securityfs_remove(files[i]);
> > > +
> > > +		kfree(files);
> > > +	}
> > > +}
> > > +
> > > +static int create_measurements_list_files(void)
> > 
> > And remove '_files' from the function name.  Perhaps rename it to
> > create_measurement_lists or create_securityfs_measurement_lists.
> 
> I think that keeping this structure for the names
> 'remove_securityfs_measurement_lists' and
> 'create_securityfs_measurement_lists'
> makes sense.

Agreed.

thanks,

Mimi


