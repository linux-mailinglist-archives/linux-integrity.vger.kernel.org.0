Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB78C12CE0
	for <lists+linux-integrity@lfdr.de>; Fri,  3 May 2019 13:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfECLsa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 May 2019 07:48:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58294 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727394AbfECLs3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 May 2019 07:48:29 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x43Bkqok105348
        for <linux-integrity@vger.kernel.org>; Fri, 3 May 2019 07:48:28 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s8km73cw6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 May 2019 07:48:28 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 3 May 2019 12:48:26 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 May 2019 12:48:24 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x43BmOAu49217538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 May 2019 11:48:24 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3229AE051;
        Fri,  3 May 2019 11:48:23 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F4ACAE045;
        Fri,  3 May 2019 11:48:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.95.126])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 May 2019 11:48:23 +0000 (GMT)
Subject: Re: [PATCH] integrity: make 'sync' update the inode integrity state
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Janne Karhunen <janne.karhunen@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Fri, 03 May 2019 07:48:12 -0400
In-Reply-To: <1554987784.7843.40.camel@linux.ibm.com>
References: <20190410145659.26347-1-janne.karhunen@gmail.com>
         <1554987784.7843.40.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19050311-0020-0000-0000-00000338E393
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050311-0021-0000-0000-0000218B6FF4
Message-Id: <1556884092.4754.17.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-03_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=870 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905030075
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-04-11 at 09:03 -0400, Mimi Zohar wrote:
> On Wed, 2019-04-10 at 17:56 +0300, Janne Karhunen wrote:
> 
> > +		clear_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
> > +		if (!IS_I_VERSION(inode) ||
> > +		    !inode_eq_iversion(inode, iint->version)) {
> > +			iint->flags &= ~IMA_COLLECTED;
> > +			ima_update_xattr(iint, file);
> 
> Relatively recently there were some changes to iversion so that it
> isn't being updated as frequently.  Can we use i_version here?

I was referring to Jeff Layton's i_version changes.[1]

Mimi

[1] f02a9ad1f15d ("fs: handle inode->i_version more efficiently")

> 
> > +		}
> > +	}
> > +	mutex_unlock(&iint->mutex);
> > +}
> > +EXPORT_SYMBOL_GPL(ima_file_update);
> > +
> >  /**
> >   * ima_path_check - based on policy, collect/store measurement.
> >   * @file: pointer to the file to be measured

