Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 545F49679E
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Aug 2019 19:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfHTRcJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Aug 2019 13:32:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:28892 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbfHTRcJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Aug 2019 13:32:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 10:32:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="378646993"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga006.fm.intel.com with ESMTP; 20 Aug 2019 10:32:08 -0700
Received: from fmsmsx126.amr.corp.intel.com (10.18.125.43) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 20 Aug 2019 10:32:08 -0700
Received: from fmsmsx103.amr.corp.intel.com ([169.254.2.141]) by
 FMSMSX126.amr.corp.intel.com ([169.254.1.24]) with mapi id 14.03.0439.000;
 Tue, 20 Aug 2019 10:32:07 -0700
From:   "Oliver, Dario N" <dario.n.oliver@intel.com>
To:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: WARNING: lock held when returning to user space!
Thread-Topic: WARNING: lock held when returning to user space!
Thread-Index: AdVXfS6rIPRFVuvoTYm0GpaOY1OQdg==
Date:   Tue, 20 Aug 2019 17:32:06 +0000
Message-ID: <20A6FE0AC912764FB8B5BC5A1A7CB92B3BBD1557@FMSMSX103.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTUyZTE4OTUtYzViYy00NTY2LTkyZDUtNTY1MzA1YjY2YTNjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQ0prMUMxRzRoemR1SVE4OHRrZ1FzZUE3QmwxYjJBUm5mbmd3c1VBc1k3U0E4WGRyNW1tbXF5Rlg0b0RQMTRpUiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.1.200.108]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

I am currently experiencing the following warning when using the tpm2-software/tpm2-tools, latchset/clevis tools. 
This was originally reported in the tpm2-tools repository here https://github.com/tpm2-software/tpm2-tools/issues/1676
The maintainer of tpm2-tools suggested that I should report this issue to the linux-integrity distribution list.

1656.971592] ================================================
[ 1656.971605] WARNING: lock held when returning to user space!
[ 1656.971619] 5.3.0-0.rc3.git1.1.fc31.x86_64 #1 Tainted: G        W        
[ 1656.971633] ------------------------------------------------
[ 1656.971646] tpm2_createprim/3229 is leaving the kernel with locks still held!
[ 1656.971662] 2 locks held by tpm2_createprim/3229:
[ 1656.971672]  #0: 0000000040f82a51 (&chip->ops_sem){.+.+}, at: tpm_try_get_ops+0x23/0x90
[ 1656.971700]  #1: 000000005e2badf9 (&chip->tpm_mutex){+.+.}, at: tpm_try_get_ops+0x3e/0x90
[ 1666.789624] EXT4-fs (dm-3): mounted filesystem with ordered data mode. Opts: (null)

To reproduce, the clevis tool can be used to unlock an encrypted partition with tpm pin:

clevis luks unlock -d /dev/mmcblk0p1 -n c1

The OS where this is reproducible is Fedora IoT Rawhide (future 31 release), currently using the Linux Kernel 5.3
The versions of the tools I am using are the following

[root@fedora-iot-2 containers]# rpm -qa tpm2*
tpm2-tss-2.2.3-2.fc31.x86_64
tpm2-tools-3.2.0-3.fc31.x86_64

[root@fedora-iot-2 containers]# rpm -qa clevis*
clevis-luks-11-6.fc31.x86_64
clevis-11-6.fc31.x86_64
clevis-systemd-11-6.fc31.x86_64
clevis-dracut-11-6.fc31.x86_64

Regards, 

Nicolas Oliver

