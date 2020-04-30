Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B286C1BF98F
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2020 15:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgD3Ncr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Apr 2020 09:32:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2168 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726836AbgD3Ncq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Apr 2020 09:32:46 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03UDWJiF101962;
        Thu, 30 Apr 2020 09:32:37 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mggwxvy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 09:32:37 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03UDWaqj103083;
        Thu, 30 Apr 2020 09:32:36 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mggwxvx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 09:32:36 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03UDV2AZ023639;
        Thu, 30 Apr 2020 13:32:34 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 30mcu5aqc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 13:32:34 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03UDWVOM61145372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 13:32:31 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8512A405F;
        Thu, 30 Apr 2020 13:32:31 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 044F0A405C;
        Thu, 30 Apr 2020 13:32:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.170.249])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Apr 2020 13:32:30 +0000 (GMT)
Message-ID: <1588253550.5167.26.camel@linux.ibm.com>
Subject: Re: Fwd: a8d5875ce5 ("Default enable RCU list lockdep debugging
 with .."): WARNING: suspicious RCU usage
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, Matthew Garrett <mjg59@google.com>
Date:   Thu, 30 Apr 2020 09:32:30 -0400
In-Reply-To: <20200430130713.GA27353@madhuparna-HP-Notebook>
References: <5ea3a0e3.ruR9Zw9VIGN+NGIb%lkp@intel.com>
         <CAD=jOEYd-pAQMo3hukx6AhXN7CbH8yGLVLHe2=92wCq-HWS++Q@mail.gmail.com>
         <1588035506.16086.25.camel@linux.ibm.com>
         <20200428112349.GA19116@madhuparna-HP-Notebook>
         <1588078741.5195.6.camel@linux.ibm.com>
         <20200429100432.GB3465@madhuparna-HP-Notebook>
         <20200429224058.GA21975@paulmck-ThinkPad-P72>
         <20200430130713.GA27353@madhuparna-HP-Notebook>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_08:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300106
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-04-30 at 18:37 +0530, Madhuparna Bhowmik wrote:
> On Wed, Apr 29, 2020 at 03:40:58PM -0700, Paul E. McKenney wrote:
> > You do of course need the code to use the RCU variants of list_add*().
> > And also list_for_each_entry_rcu(), as in the current code.
> > 
> > There are several options, none of them perfect:
> > 
> > 1.	Add (not otherwise needed) calls to rcu_read_lock() and
> > 	rcu_read_unlock() and leave list_for_each_entry_rcu() unchanged.
> > 
> > 2.	Add "true" for the optional fourth argument to
> > 	list_for_each_entry_rcu().  This will suppress the complaints,
> > 	but would (incorrectly) continue to do so should this code change
> > 	so as to be able to delete form this list.
> > 
> > 3.	Switch from list_for_each_entry_rcu() to its lockless counterpart,
> > 	list_for_each_entry_lockless().  This is simiar to #2 above, but
> > 	at least the name lets people know that something unusual is up.
> > 
> > If it was my code, I would take door #3.  ;-)
> >
> Thanks a lot for your inputs on this. I will send a patch soon.

Please remember to expand the "mutex" comment in evm_write_xattrs() to
reflect the reason why using list_for_each_entry_lockless() is safe.

thanks,

Mimi
