Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA5F1BBE69
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Apr 2020 14:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgD1M7S (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Apr 2020 08:59:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33682 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726759AbgD1M7R (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Apr 2020 08:59:17 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03SCVvLg013168;
        Tue, 28 Apr 2020 08:59:08 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30pjxuvau0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 08:59:07 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03SCWMjq016194;
        Tue, 28 Apr 2020 08:59:07 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30pjxuvat4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 08:59:07 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03SCtglC021530;
        Tue, 28 Apr 2020 12:59:05 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 30mcu5p4yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 12:59:05 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03SCx3S67209226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 12:59:03 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 546F0AE058;
        Tue, 28 Apr 2020 12:59:03 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86F61AE053;
        Tue, 28 Apr 2020 12:59:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.198.90])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Apr 2020 12:59:02 +0000 (GMT)
Message-ID: <1588078741.5195.6.camel@linux.ibm.com>
Subject: Re: Fwd: a8d5875ce5 ("Default enable RCU list lockdep debugging
 with .."): WARNING: suspicious RCU usage
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, Matthew Garrett <mjg59@google.com>
Date:   Tue, 28 Apr 2020 08:59:01 -0400
In-Reply-To: <20200428112349.GA19116@madhuparna-HP-Notebook>
References: <5ea3a0e3.ruR9Zw9VIGN+NGIb%lkp@intel.com>
         <CAD=jOEYd-pAQMo3hukx6AhXN7CbH8yGLVLHe2=92wCq-HWS++Q@mail.gmail.com>
         <1588035506.16086.25.camel@linux.ibm.com>
         <20200428112349.GA19116@madhuparna-HP-Notebook>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-28_07:2020-04-28,2020-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004280097
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-04-28 at 16:53 +0530, Madhuparna Bhowmik wrote:
> On Mon, Apr 27, 2020 at 08:58:26PM -0400, Mimi Zohar wrote:
> > [Cc'ing Matthew Garrett)
> > 
> > Hi Madhuparna,
> > 
> > On Sat, 2020-04-25 at 16:33 +0530, Madhuparna Bhowmik wrote:
> > > Hi,
> > > 
> > > This is regarding the warning reported by kernel test bot regarding
> > > suspicious RCU usage.
> > > Using a simple git grep, I can only see the following usage of RCU:
> > > 
> > > evm_crypto.c:   list_for_each_entry_rcu(xattr, &evm_config_xattrnames,
> > > list) {
> > > evm_main.c:     list_for_each_entry_rcu(xattr, &evm_config_xattrnames,
> > > list) {
> > > evm_main.c:     list_for_each_entry_rcu(xattr, &evm_config_xattrnames,
> > > list) {
> > > evm_secfs.c:    list_add_tail_rcu(&xattr->list, &evm_config_xattrnames);
> > > 
> > > So, the evm_config_xattrnames list is traversed using
> > > list_for_each_entry_rcu() but without the protection of rcu_read_lock()?
> > > If these are not really RCU read-side CS, and other locks are held then
> > > there is no need to use list_for_each_entry_rcu().
> > > And maybe we can completely remove the usage of rcu primitives here.
> > > Or if there is a bug and rcu_read_lock() should be held, please let me know
> > > and I can try fixing this.
> > 
> > Thank you for forwarding this report.  The list of EVM xattrs is
> > protected by the xattr_list_mutex, which is used when reading or
> > appending to the EVM list itself.  Entries in the list can not be
> > removed.
> >
> Hi Mimi,
> 
> Thank you for your reply.
> So, if the list is protected by xattr_list mutex and it is used during
> both reading and writing to the list, can we remove the usage of RCU
> here? 

I should have said the mutex is used when cat'ing the securityfs file
(security/integrity/evm/evm_xattrs) and when adding to the list, but
not in the above cases when walking the list.

> Since the read side critical section is already protected by the
> xattr_list mutex, we do not need list_for_each_entry_rcu() to read the
> list. Also, we can just simply add to the list using list_add_tail(),
> RCU primitives are not really required here.
> 
> Please let me know is this is fine, and I can send a patch removing the
> usage of RCU here.

Matthew, please correct me if I'm wrong, the reason it is safe, is not
because there is a mutex, but because entries are never removed from
the list.

Mimi

> > The examples, above, are all readers, which walk the EVM xattr list in
> > order to calculate or verify a file's security.evm xattr.


