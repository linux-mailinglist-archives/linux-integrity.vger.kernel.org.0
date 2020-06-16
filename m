Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06E11FC1C5
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2020 00:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgFPWk0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 18:40:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725901AbgFPWk0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 18:40:26 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05GMX8hp025786;
        Tue, 16 Jun 2020 18:40:17 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31q6j4grn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Jun 2020 18:40:17 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05GMb6sB040484;
        Tue, 16 Jun 2020 18:40:16 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31q6j4grmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Jun 2020 18:40:16 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05GMeF2k032083;
        Tue, 16 Jun 2020 22:40:15 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 31q6bs81kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Jun 2020 22:40:14 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05GMeCeI983414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jun 2020 22:40:12 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C60CA52097;
        Tue, 16 Jun 2020 22:40:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.158.198])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 94F5E52096;
        Tue, 16 Jun 2020 22:40:11 +0000 (GMT)
Message-ID: <1592347211.11061.250.camel@linux.ibm.com>
Subject: Re: [LTP v2 1/1] ima_tpm.sh: Fix for calculating boot aggregate
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Bruno Meneguele <bmeneg@redhat.com>, Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Petr Cervinka <pcervinka@suse.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>
Date:   Tue, 16 Jun 2020 18:40:11 -0400
In-Reply-To: <20200615200121.GG129694@glitch>
References: <20200527071434.28574-1-pvorel@suse.cz>
         <1590601280.16219.1.camel@linux.ibm.com> <20200528140747.GA8401@dell5510>
         <1590679145.4457.39.camel@linux.ibm.com> <20200528160527.GA27243@dell5510>
         <20200615194134.GF129694@glitch> <20200615200121.GG129694@glitch>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-16_13:2020-06-16,2020-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 adultscore=0 mlxscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 cotscore=-2147483648 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006160154
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-06-15 at 17:01 -0300, Bruno Meneguele wrote:
> On Mon, Jun 15, 2020 at 04:41:34PM -0300, Bruno Meneguele wrote:
> > On Thu, May 28, 2020 at 06:05:27PM +0200, Petr Vorel wrote:

> > > > The boot_aggregate.trs and boot_aggregate.log files are being created
> > > > in the tests/ directory.  Is that directory read-only?
> > > Yes, drwxr-xr-x. Testing on fresh clone and issue persists.
> > > 
> > 
> > Yes, same thing here.. but didn't really check the reason for that. Will
> > take a time later to see what's happening.

Cloning as root will cause that to happen.

$ sudo git clone git://git.code.sf.net/p/linux-ima/ima-evm-utils --branch next-testing
Cloning into 'ima-evm-utils'...
remote: Enumerating objects: 1154, done.
remote: Counting objects: 100% (1154/1154), done.
remote: Compressing objects: 100% (1052/1052), done.
remote: Total 1154 (delta 736), reused 182 (delta 96)
Receiving objects: 100% (1154/1154), 335.12 KiB | 0 bytes/s, done.
Resolving deltas: 100% (736/736), done.
Checking connectivity... done.

$ ls -lat ima-evm-utils/ | grep tests
drwxr-xr-x.  2 root root   220 Jun 16 18:28 tests

Mimi
