Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790186A1DBE
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Feb 2023 15:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjBXOsm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Feb 2023 09:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjBXOsl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Feb 2023 09:48:41 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C71383E4;
        Fri, 24 Feb 2023 06:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677250104; i=linosanfilippo@gmx.de;
        bh=YelkDbTnQ/zyAAob9B2ze+jP4qbVvwZlTqkb84H8HuI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KRQ/DeTP18QEo4PNE+InOcqyXXPn0YoaYcpwi12fTyUqnzcJxwl/bey54c2au0TrD
         14DkehD48trktrnwTAKQeb771rT2T0xI9Pzdtg6Hh2annlZmbp1qN1Gjtnj6P9+nKL
         fh2cb0ZbBIUQnYwuoUPs739AXtekTwD2OnsolowcPtRVvUsryv2NYQiC7xP8JGsubL
         taGXQTmAR1e5rR4dvIrJdstrDLHxhN51WJfK2edih5cT82+kZLTBSztRspMQQjQ36W
         1Y7cupycJUAHyEdq8ugp7I+YfergbMcKX19QLQvYofv/GecBEA7bCmWgkbdMUaBVXM
         Q1x5QFzpZrMOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.37] ([84.162.10.217]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMobO-1pEzvQ0Wuq-00IpgN; Fri, 24
 Feb 2023 15:48:24 +0100
Subject: Re: [PATCH v11 00/14] TPM IRQ fixes
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
References: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <4c094418-7725-b815-f1f9-8b12f1ac4d72@gmx.de>
Date:   Fri, 24 Feb 2023 15:48:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E/eoRPjDHLXwal2VRTn9BCbGZq6XwRxeMh4B7CeCfWpwVvm17go
 QXnRA57+vKPXWpVVwJMRDEh3GBSK+D4j56XYA+tR0rCKZDDnUz4wK7W859L0mbnF66QU0R+
 L78W2gIUcl9wMkx/01VsBAQD2iw7V/4872hYheXPoKV849JFqts9xrVR/8kiaGrHy9fPJPa
 FoyZ8FWq42QB6MntsRp8g==
UI-OutboundReport: notjunk:1;M01:P0:d6qHNZNlTRw=;DAJCia3xrEr0b7Mx3Z3z10KbfNp
 t8MbwQ7yVXho/DXZvPWd3PIhKqrc9Lwu0mNCQOwU4gZ61yWzw9aEa5j4GeODoo7CSMRL8IhuO
 bsNuLcuYduT7H1ex7P/+OtWiFBifZSbgM8muoNNxVa1z9eHpKmNzfX5QN5YkJvKvRyXKxaiMJ
 11jAprCy/aglhYiRhGf7ChqcGiG+K3AuzMnYfYsImfCJLHtELHHTyo09vrFZpfNQBMLT26G0C
 xN7rrujvtGvKuMztzWdPUrCRNpWreRgSYbsADtMQoYQ3lXVRh/LRDxTadXp9ReY6aQwaD1YRP
 GnWW/dKv2VveP9IxcqARp0orusD99r/gWXMhuwOHwbJJf0Nh42UhOsYCQlQVTYEt39HRYKfqg
 15IBhpuP59IqZMU/It5XRDrnTCBGd42s8tlgmms6QDFoIyyO02ITk3yB9tORLHfH17sP4d/Z9
 NlSLTpKSdfv24kvO+GuHnRbpSIHkECIiVIif9+WPwBNY6dQj+Mitx6hvpej2fuddaLz0WRh5q
 Zs/iFnynapTbW/oDkhdRGzBzZxF9ATAKJ7KYnaz41YZOxEyBxBnM+s63G60waU+BIeqAXJJK9
 21Yr7wKEQAscAVM3xU924JiEhCJ7Cwgw5k16COYHERHjaSDzJeYXtw/R1OuxkpsHftdy6KMB6
 pPzNPUHFmc/6aXX/NAfmE7GpK0c+hjSBxuSBZJ4cqYiGxggtqv4lb8VS6lWPI47+8cBHkrJVD
 VWlGfUg5w7iS17E54+bObMn6GCL3oAHuct3iC35Eju58yWSqK1l3YI/lDwgxfZ7XpHzOaTUZD
 h3jJSNoE6BUB9uJPZFzWJm8XXxlLdWrMhO0t2U7Kpr31iz/lIKyY3uZpRMtCq7AuUtnwJ3I4K
 Bk0s7swt8lbkkSwFCrk2xbe1FbYk2Tdk2ScTBYx8o2fDcP2sWcXkP3Zw/5JvKRN8CS7ouqhw9
 Y5ACjw==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 24.11.22 at 14:55, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>
> This series enables IRQ support for the TPM TIS core. For this reason a
> number of bugfixes around the interrupt handling are required (patches 1=
 to
> 5).
>
> Patch 6 takes into account that according to the TPM Interface
> Specification stsValid and commandRead interrupts might not be supported
> by the hardware. For this reason the supported interrupts are first quer=
ied
> and stored. Then wait_for_tpm_stat() is adjusted to not wait for status
> changes that are not reported by interrupts.
>
> Patch 7 moves the interrupt flag checks into an own function as suggeste=
d
> by Jarkko.
>
> Patch 8 Removes the possibility that tpm_tis_data->locality can be chang=
ed
> at driver runtime so this variable can be read without the need to prote=
ct
> it against concurrent modification.
>
> Patch 9 addresses the issue with concurrent locality handling:
> Since the interrupt handler writes the interrupt status registers it nee=
ds
> to hold the locality. However it runs concurrently to the thread which
> triggered the interrupt (e.g. by reading or writing data to the TPM). So
> it must take care when claiming and releasing the locality itself,
> because it may race with the concurrent running thread which also claims
> and releases the locality.
> To avoid that both interrupt and concurrent running thread interfere wit=
h
> each other a locality counter is used which guarantees that at any time
> the locality is held as long as it is required by one of both execution
> paths.
>
> Patch 10 implements the request of a threaded interrupt handler. This is
> needed since SPI uses a mutex for data transmission and since we access =
the
> interrupt status register via SPI in the irq handler we need a sleepable
> context.
>
> Patch 11 makes sure that writes to the interrupt register are effective =
if
> done in the interrupt handler.
>
> Patch 12 makes sure that writes to the interrupt and INTERRUPT_VECTOR
> and INTERRUPT_ENABLE registers are effective by holding the locality.
>
> Patch 13 makes sure that the TPM is properly initialized after power cyc=
le
> before the irq test is done.
>
> Patch 14 enables the test for interrupts by setting the required flag
> before the test is executed.
>
> Changes in v11:
> - adjust patches 4,5 and 14 slightly to void the consecutive removal and
>   re-addition of the "ret" variable in tpm_tis_gen_interrupt()
>
> Changes in v10:
> - fix typo in subject line as pointed out by Jason Andryuk
> - improve patch "tpm, tpm_tis: Claim locality before writing interrupt
>   registers" by extending the scope with held locality". For this reason
>   the "Reviewed-by" tag by Jarko and the "Tested-by" tag by Michael have
>   been removed.
> - add fix to avoid TPM_RC_INITIALIZE after power cycle when testing irqs
>   (PATCH 13)
> - add fix to restore the old interrupt vector at error (PATCH 4)
>
>
> Changes in v9:
> - add a fix for an issue when interrupts are reenabled on resume (PATCH =
11)
> - improve the commit message for patch 8 as requested by Jarkko
> - improved functions naming
> - changed patch 12 (tpm, tpm_tis: Enable interrupt test) to not delete t=
he
>   TPM_CHIP_FLAG_IRQ flag any more when tpm2_get_tpm_pt() fails. Due to t=
his
>   change the 'Tested-by' tag from Michael and the 'Reviewed-by:' tag fro=
m
>   Jarko has been removed
>
> Changes in v8:
> - tpm_tis_data->locality is not changed at runtime any more so that it c=
an
> be read without any protection against concurrent modification.
> - add missing brackets as pointed out by Jason Andryuk
>
> Changes in v7:
> - moved interrupt flag checks into an own function as suggested by Jarkk=
o
> - added "Tested-by" tags for Tests from Michael Niew=C3=B6hner
> - fixed one comment
>
> Changes in v6:
> - set TPM_TIS_IRQ_TESTED in flag member of the tpm_tis_data struct inste=
ad
> in an own bitfield
> - improve commit messages
> - use int_mask instead of irqs_in_use as variable name
> - use sts_mask instead of active_irqs as variable name
> - squash patch 5 and 6
> - prefix functions with tpm_tis_
> - remove "fixes" tag
>
> Changes in v5:
> - improve commit message of patch 1 as requested by Jarko
> - drop patch that makes locality handling simpler by only claiming it at
>   driver startup and releasing it at driver shutdown (requested by Jarko=
)
> - drop patch that moves the interrupt test from tpm_tis_send()
>   to tmp_tis_probe_irq_single() as requested by Jarko
> - add patch to make locality handling threadsafe so that it can also be
>   done by the irq handler
> - separate logical changes into own patches
> - always request threaded interrupt handler
>
> Changes in v4:
> - only request threaded irq in case of SPI as requested by Jarko.
> - reimplement patch 2 to limit locality handling changes to the TIS core=
.
> - separate fixes from cleanups as requested by Jarko.
> - rephrase commit messages
>
> Changes in v3:
> - fixed compiler error reported by kernel test robot
> - rephrased commit message as suggested by Jarko Sakkinen
> - added Reviewed-by tag
>
> Changes in v2:
> - rebase against 5.12
> - free irq on error path
>
>
> Lino Sanfilippo (14):
>   tpm, tpm_tis: Avoid cache incoherency in test for interrupts
>   tpm, tpm_tis: Claim locality before writing TPM_INT_ENABLE register
>   tpm, tpm_tis: Disable interrupts if tpm_tis_probe_irq() failed
>   tpm, tpm_tis: Do not skip reset of original interrupt vector
>   tpm, tpm_tis: Claim locality before writing interrupt registers
>   tpm, tpm_tis: Only handle supported interrupts
>   tpm, tpm_tis: Move interrupt mask checks into own function
>   tpm, tpm_tis: do not check for the active locality in interrupt
>     handler
>   tpm, tpm: Implement usage counter for locality
>   tpm, tpm_tis: Request threaded interrupt handler
>   tpm, tpm_tis: Claim locality in interrupt handler
>   tpm, tpm_tis: Claim locality when interrupts are reenabled on resume
>   tpm, tpm_tis: startup chip before testing for interrupts
>   tpm, tpm_tis: Enable interrupt test
>
>  drivers/char/tpm/tpm-chip.c     |  38 ++--
>  drivers/char/tpm/tpm.h          |   1 +
>  drivers/char/tpm/tpm_tis.c      |   2 +-
>  drivers/char/tpm/tpm_tis_core.c | 299 ++++++++++++++++++++------------
>  drivers/char/tpm/tpm_tis_core.h |   5 +-
>  5 files changed, 214 insertions(+), 131 deletions(-)
>

Hi Jarkko,

its been a while now since the review of this series has been completed. W=
ill it be merged in the
near future? Or is there anything left to do (from my side)?

Regards,
Lino

